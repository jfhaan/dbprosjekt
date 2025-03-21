# Importerer nødvendige pakker
import sqlite3
from datetime import datetime

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

def get_flight_routes_with_segments(conn, ukedag, start_flyplass, slutt_flyplass):
    cursor = conn.cursor()
    result = []
    
    # Først finn alle mulige ruter (både direkte og med mellomlandinger)
    cursor.execute("""
                   WITH RECURSIVE
                   MuligeRuter AS (
                       -- Direkte ruter
                       SELECT 
                           rs.Id,
                           rs.Flyrutenummer,
                           rs.PlanlagtAvgang,
                           rs.PlanlagtAnkomst,
                           rs.Startflyplass,
                           rs.Sluttflyplass,
                           rs.Startflyplass || ',' || rs.Sluttflyplass as Reiserute,
                           1 as Antall_Stopp
                       FROM RuteStrekning rs
                       JOIN Flyrute f ON rs.Flyrutenummer = f.Flyrutenummer
                       WHERE rs.Startflyplass = ?
                       AND f.Ukedagskode LIKE ?
                       
                       UNION ALL
                       
                       -- Legg til neste delstrekning
                       SELECT 
                           rs.Id,
                           rs.Flyrutenummer,
                           m.PlanlagtAvgang,
                           rs.PlanlagtAnkomst,
                           m.Startflyplass,
                           rs.Sluttflyplass,
                           m.Reiserute || ',' || rs.Sluttflyplass,
                           m.Antall_Stopp + 1
                       FROM RuteStrekning rs
                       JOIN MuligeRuter m ON rs.Startflyplass = substr(m.Reiserute, -3)
                           AND rs.Flyrutenummer = m.Flyrutenummer
                       WHERE rs.PlanlagtAvgang > m.PlanlagtAnkomst
                       AND m.Antall_Stopp < 3
                   )
                   SELECT * FROM MuligeRuter 
                   WHERE Sluttflyplass = ?
                   ORDER BY Antall_Stopp, PlanlagtAvgang
                   """, (start_flyplass, f"%{ukedag}%", slutt_flyplass))
    
    mulige_ruter = cursor.fetchall()
    
    for rute in mulige_ruter:
        flyrutenummer = rute[1]
        
        # Hent alle delstrekninger for denne ruten
        cursor.execute("""
                       SELECT *
                       FROM RuteStrekning
                       WHERE Flyrutenummer = ?
                       AND Startflyplass >= ?
                       AND Sluttflyplass <= ?
                       ORDER BY PlanlagtAvgang
                       """, (flyrutenummer, start_flyplass, slutt_flyplass))
        
        delstrekninger = cursor.fetchall()
        
        if len(delstrekninger) > 1:
            # Ruten kan dekomponeres i delstrekninger
            route_info = {
                'rutenummer': flyrutenummer,
                'hovedrute': delstrekninger[-1],  # Siste delstrekning inneholder total reisetid
                'er_delstrekning': False,
                'segmenter': delstrekninger,
                'antall_segmenter': len(delstrekninger),
                'mellomlandinger': [d[5] for d in delstrekninger[:-1]]  # Alle mellomlandinger
            }
        else:
            # Dette er en direkterute
            route_info = {
                'rutenummer': flyrutenummer,
                'hovedrute': delstrekninger[0],
                'er_delstrekning': False,
                'segmenter': delstrekninger,
                'antall_segmenter': 1,
                'mellomlandinger': []
            }
        
        result.append(route_info)
    
    return result

def main():
    conn = connect_to_db()
    print("\n ==== Velkommen til flyvningsvelgeren ===")

    # Få dato fra brukeren og konverter til ukedagskode
    while True:
        try:
            dato = input("\nSkriv inn dato (DD.MM.ÅÅÅÅ): ")
            dato_obj = datetime.strptime(dato, "%d.%m.%Y")
            ukedagskode = str((dato_obj.weekday() + 1) % 7)  # Konverterer til 0-6 hvor 0 er søndag
            break
        except ValueError:
            print("Ugyldig datoformat. Vennligst bruk formatet DD.MM.ÅÅÅÅ")

    # Henter flyplasser fra databasen
    flyplasser = get_airports(conn) 
    flyplasser_valg = [f"{kode} - {navn}" for kode, navn in flyplasser]

    print("\nTilgjengelige flyplasser:")
    for i, valg in enumerate(flyplasser_valg, 1):
        print(f"{i}. {valg}")
    
    valg = int(input("\nSkriv inn nummeret for den flyplassen du vil reise fra: "))
    start_flyplass = flyplasser[valg - 1][0]
    
    valg = int(input("Skriv inn nummeret for den flyplassen du vil reise til: "))
    slutt_flyplass = flyplasser[valg - 1][0]

    # Henter flyruter fra databasen
    flyruter = get_flight_routes_with_segments(conn, ukedagskode, start_flyplass, slutt_flyplass)

    # Skriver ut flyruter
    if flyruter:
        print(f"\nFlyruter mellom {start_flyplass} og {slutt_flyplass} på valgt dato:")
        for rute in flyruter:
            print(f"\nFlyrutenummer: {rute['rutenummer']}")
            if rute['er_delstrekning']:
                print("Dette er en delstrekning av en lengre rute:")
            print(f"Strekning: {rute['hovedrute'][4]} -> {rute['hovedrute'][5]}")
            print(f"  Planlagt avgang: {rute['hovedrute'][2]}")
            print(f"  Planlagt ankomst: {rute['hovedrute'][3]}")
            
            if rute['antall_segmenter'] > 1:
                print("\nDenne reisen består av følgende delstrekninger:")
                for segment in rute['segmenter']:
                    print(f"  {segment[4]} -> {segment[5]}")
                    print(f"    Avgang: {segment[2]}, Ankomst: {segment[3]}")
                print(f"  Mellomlanding i: {', '.join(rute['mellomlandinger'])}")
    else:
        print(f"\nIngen flyruter funnet mellom {start_flyplass} og {slutt_flyplass} på den valgte datoen.")

    conn.close()

if __name__ == '__main__':
    main()