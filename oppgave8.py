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
                       SELECT DISTINCT
                           rs.Id,
                           rs.Flyrutenummer,
                           rs.PlanlagtAvgang,
                           rs.PlanlagtAnkomst,
                           rs.Startflyplass,
                           rs.Sluttflyplass,
                           rs.Startflyplass || ',' || rs.Sluttflyplass as Reiserute,
                           1 as Antall_Stopp,
                           0 as Er_Delstrekning
                       FROM RuteStrekning rs
                       JOIN Flyrute f ON rs.Flyrutenummer = f.Flyrutenummer
                       JOIN Flyvning fly ON rs.Id = fly.RuteStrekningId
                       WHERE rs.Startflyplass = ?
                       AND f.Ukedagskode LIKE ?
                       AND fly.FlyvningStatus = 'planned'
                       
                       UNION ALL
                       
                       -- Legg til neste delstrekning
                       SELECT DISTINCT
                           rs.Id,
                           rs.Flyrutenummer,
                           m.PlanlagtAvgang,
                           rs.PlanlagtAnkomst,
                           m.Startflyplass,
                           rs.Sluttflyplass,
                           m.Reiserute || ',' || rs.Sluttflyplass,
                           m.Antall_Stopp + 1,
                           1 as Er_Delstrekning
                       FROM RuteStrekning rs
                       JOIN MuligeRuter m ON rs.Startflyplass = substr(m.Reiserute, -3)
                           AND rs.Flyrutenummer = m.Flyrutenummer
                       JOIN Flyvning fly ON rs.Id = fly.RuteStrekningId
                       WHERE rs.PlanlagtAvgang > m.PlanlagtAnkomst
                       AND m.Antall_Stopp < 3
                       AND fly.FlyvningStatus = 'planned'
                   )
                   SELECT DISTINCT m.*
                   FROM MuligeRuter m
                   LEFT JOIN (
                       SELECT Flyrutenummer, MAX(Antall_Stopp) as max_stopp
                       FROM MuligeRuter
                       WHERE Sluttflyplass = ?
                       GROUP BY Flyrutenummer
                   ) ms ON m.Flyrutenummer = ms.Flyrutenummer
                   WHERE m.Sluttflyplass = ?
                   AND m.Antall_Stopp = ms.max_stopp
                   ORDER BY m.Antall_Stopp, m.PlanlagtAvgang
                   """, (start_flyplass, f"%{ukedag}%", slutt_flyplass, slutt_flyplass))
    
    mulige_ruter = cursor.fetchall()
    
    for rute in mulige_ruter:
        flyrutenummer = rute[1]
        
        # Hent alle delstrekninger for denne ruten
        cursor.execute("""
                       SELECT DISTINCT rs.*
                       FROM RuteStrekning rs
                       JOIN Flyvning fly ON rs.Id = fly.RuteStrekningId
                       WHERE rs.Flyrutenummer = ?
                       AND rs.Startflyplass = ?
                       AND rs.Sluttflyplass = ?
                       AND fly.FlyvningStatus = 'planned'
                       ORDER BY rs.PlanlagtAvgang
                       """, (flyrutenummer, start_flyplass, slutt_flyplass))
        
        delstrekninger = cursor.fetchall()
        
        # Sjekk om det finnes delstrekninger før vi fortsetter
        if not delstrekninger:
            continue
            
        if len(delstrekninger) > 1:
            # Ruten kan dekomponeres i delstrekninger
            route_info = {
                'rutenummer': flyrutenummer,
                'hovedrute': delstrekninger[-1],  # Siste delstrekning inneholder total reisetid
                'er_delstrekning': True,
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

def get_available_seats(conn, rute_strekning_id, dato):
    cursor = conn.cursor()
    
    # Hent flytype for ruten
    cursor.execute("""
                   SELECT f.Flytype
                   FROM Flyrute f
                   JOIN RuteStrekning rs ON f.Flyrutenummer = rs.Flyrutenummer
                   WHERE rs.Id = ?
                   """, (rute_strekning_id,))
    flytype = cursor.fetchone()[0]
    
    # Hent alle seter for flytypen
    cursor.execute("""
                   SELECT s.Rad, s.Plass
                   FROM Sete s
                   WHERE s.Flytype = ?
                   ORDER BY s.Rad, s.Plass
                   """, (flytype,))
    alle_seter = cursor.fetchall()
    
    # Hent alle opptatte seter for denne flyvningen på den valgte datoen
    cursor.execute("""
                   SELECT b.Sete
                   FROM Billett b
                   JOIN Flyvning f ON b.Flyvning = f.Loepenummer
                   WHERE f.RuteStrekningId = ?
                   AND f.FaktiskAvgang LIKE ?
                   """, (rute_strekning_id, f"{dato}%"))
    opptatte_seter = [b[0] for b in cursor.fetchall()]
    
    # Finn ledige seter
    ledige_seter = []
    for rad, plass in alle_seter:
        sete = f"{rad}{plass}"  # Lag sete-strengen
        if sete not in opptatte_seter:
            try:
                rad_num = int(rad)
                ledige_seter.append((rad_num, plass))
            except ValueError:
                continue  # Hopp over hvis rad ikke er et tall
    
    return sorted(ledige_seter)


def main():
    conn = connect_to_db()
    print("\n ==== Velkommen til flyvningsvelgeren ===")

    # Få dato fra brukeren og konverter til ukedagskode
    while True:
        try:
            dato = input("\nSkriv inn dato (DD.MM.ÅÅÅÅ): ")
            dato_obj = datetime.strptime(dato, "%d.%m.%Y")
            ukedagskode = str(dato_obj.weekday() + 1)  # Konverterer til 1-7 hvor 1 er mandag
            # Konverter dato til format som brukes i databasen (YYYY-MM-DD)
            db_dato = dato_obj.strftime("%Y-%m-%d")
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
            
            # Vis ledige seter for hver delstrekning
            print("\nLedige seter for hver delstrekning:")
            for segment in rute['segmenter']:
                print(f"\nStrekning: {segment[4]} -> {segment[5]}")
                ledige_seter = get_available_seats(conn, segment[0], db_dato)
                if ledige_seter:
                    print("Ledige seter:")
                    # Grupper seter etter rad
                    rader = {}
                    for rad, plass in ledige_seter:
                        if rad not in rader:
                            rader[rad] = []
                        rader[rad].append(plass)
                    # Skriv ut hver rad på en egen linje
                    for rad in sorted(rader.keys()):
                        print(f"  Rad {rad}: {', '.join(sorted(rader[rad]))}")
                else:
                    print("Ingen ledige seter på denne strekningen")
            print("\n" + "="*50)  # Legg til en skillelinje mellom rutene
    else:
        print(f"\nIngen flyruter funnet mellom {start_flyplass} og {slutt_flyplass} på den valgte datoen.")

    conn.close()

if __name__ == '__main__':
    main()