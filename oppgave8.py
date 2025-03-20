# Importerer nødvendige pakker
import sqlite3

# Koble til databasen
def connect_to_db():
    conn = sqlite3.connect('fly.db')
    return conn

# Henter flyplasser fra databasen
def get_airports(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT Kode, Navn FROM Flyplass ORDER BY Kode")
    airports = cursor.fetchall()
    return airports

def get_flight_routes_with_segments(conn, start_flyplass, slutt_flyplass):
    cursor = conn.cursor()
    
    # Først finn direkte ruter mellom start og slutt
    cursor.execute("""
                   SELECT *
                   FROM RuteStrekning
                   WHERE Startflyplass = ? AND Sluttflyplass = ?
                   """, (start_flyplass, slutt_flyplass))
    
    direkte_ruter = cursor.fetchall()
    
    # Finn potensielle delstrekninger som kan kobles sammen
    cursor.execute("""
                   WITH Delstrekninger AS (
                       SELECT r1.*, r2.*
                       FROM RuteStrekning r1
                       JOIN RuteStrekning r2 ON r1.Sluttflyplass = r2.Startflyplass 
                           AND r1.Flyrutenummer = r2.Flyrutenummer
                       WHERE r1.Startflyplass = ? 
                           AND r2.Sluttflyplass = ?
                           AND r2.PlanlagtAvgang > r1.PlanlagtAnkomst
                   )
                   SELECT * FROM Delstrekninger
                   """, (start_flyplass, slutt_flyplass))
    
    sammensatte_ruter = cursor.fetchall()
    
    result = []
    
    # Håndter direkte ruter
    for rute in direkte_ruter:
        # Sjekk om denne ruten egentlig er en del av en sammensatt rute
        cursor.execute("""
                      SELECT COUNT(*)
                      FROM RuteStrekning
                      WHERE Flyrutenummer = ?
                        AND ((Startflyplass = ? AND Sluttflyplass != ?)
                         OR (Startflyplass != ? AND Sluttflyplass = ?))
                      """, (rute[1], rute[4], rute[5], rute[4], rute[5]))
        
        er_del_av_sammensatt = cursor.fetchone()[0] > 0
        
        if not er_del_av_sammensatt:
            route_info = {
                'rutenummer': rute[1],
                'segmenter': [rute],
                'antall_segmenter': 1,
                'mellomlandinger': []
            }
            result.append(route_info)
    
    # Håndter sammensatte ruter
    for rute in sammensatte_ruter:
        # Del opp i to segmenter (første og andre del av ruten)
        første_segment = rute[0:6]
        andre_segment = rute[6:]
        
        route_info = {
            'rutenummer': første_segment[1],  # Bruker rutenummeret fra første segment
            'segmenter': [første_segment, andre_segment],
            'antall_segmenter': 2,
            'mellomlandinger': [første_segment[5]]  # Mellomlandingsflyplass er sluttflyplassen til første segment
        }
        result.append(route_info)
    
    return result

def main():
    conn = connect_to_db()
    print("\n ==== Velkommen til flyvningsvelgeren ===")

    # Henter flyplasser fra databasen
    flyplasser = get_airports(conn) 
    flyplasser_valg = [f"{kode} - {navn}" for kode, navn in flyplasser]

    print("\nHvor vil du reise fra?")
    for i, valg in enumerate(flyplasser_valg, 1):
        print(f"{i}. {valg}")

    valg = int(input("Skriv inn nummeret for den flyplassen du vil reise fra: "))
    start_flyplass = flyplasser[valg - 1][0]
    
    print("\nHvor vil du reise til?")
    for i, valg in enumerate(flyplasser_valg, 1):
        print(f"{i}. {valg}")
    valg = int(input("Skriv inn nummeret for den flyplassen du vil reise til: "))
    slutt_flyplass = flyplasser[valg - 1][0]

    # Henter flyruter fra databasen
    flyruter = get_flight_routes_with_segments(conn, start_flyplass, slutt_flyplass)

    # Skriver ut flyruter
    if flyruter:
        print(f"\nFlyruter mellom {start_flyplass} og {slutt_flyplass}")
        for rute in flyruter:
            print(f"\nFlyrutenummer: {rute['rutenummer']}")
        
            if rute['antall_segmenter'] > 1:
                print("Denne reisen består av følgende delstrekninger:")
                for segment in rute['segmenter']:
                    print(f"  {segment[4]} -> {segment[5]}")
                    print(f"    Avgang: {segment[2]}, Ankomst: {segment[3]}")
                print(f"  Mellomlanding i: {', '.join(rute['mellomlandinger'])}")
            else:
                print("Dette er en direkterute:")
                segment = rute['segmenter'][0]
                print(f"  {segment[4]} -> {segment[5]}")
                print(f"    Avgang: {segment[2]}, Ankomst: {segment[3]}")
    else:
        print(f"\nIngen flyruter funnet mellom {start_flyplass} og {slutt_flyplass}")

    conn.close()

    main()

if __name__ == '__main__':
    main()