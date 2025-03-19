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

# Konverterer ukedagskode til dager
def weekday_code_to_days(ukedagskode):
    dager_map = {
        '1': 'Mandag',
        '2': 'Tirsdag',
        '3': 'Onsdag',
        '4': 'Torsdag',
        '5': 'Fredag',
        '6': 'Lørdag',
        '7': 'Søndag'
    }
    return ", ".join([dager_map[dag] for dag in ukedagskode if dag in dager_map])

# Hente flyavganger eller ankomster fra databasen
def get_flight_schedule(conn, flyplass_kode, ukedag, retning):
    cursor = conn.cursor()
    # Konverterer ukedag til format for database
    ukedag_num = {
        'Mandag': '1', 'Tirsdag': '2', 'Onsdag': '3', 'Torsdag': '4',
        'Fredag': '5', 'Lørdag': '6', 'Søndag': '7'
    }[ukedag]
    # SQL-spørring basert på retning (avgang eller ankomst)
    if retning == 'Avgang': # Hvis retning er avgang
        flyplass_retning = 'rs.Startflyplass'
        sortering = 'rs.PlanlagtAvgang'
    else: # Hvis retning er ankomst
        flyplass_retning = 'rs.Sluttflyplass'
        sortering = 'rs.PlanlagtAnkomst'
    # SQL spørring
    query = f"""
    SELECT f.Flyrutenummer, rs.Startflyplass, rs.Sluttflyplass,
           rs.PlanlagtAvgang, rs.PlanlagtAnkomst, f.Ukedagskode, f.Flyselskap,
           f.Flytype
    FROM Flyrute f
    JOIN RuteStrekning rs ON f.Flyrutenummer = rs.Flyrutenummer
    WHERE {flyplass_retning} = ? AND f.Ukedagskode LIKE ?
    ORDER BY {sortering}
    """
    cursor.execute(query, (flyplass_kode, f'%{ukedag_num}%'))
    return cursor.fetchall()

# Meny valg til bruker
def meny (valgmuligheter):
    for i, valg in enumerate(valgmuligheter):
        print(f"{i}: {valg}")
    
    while True:
        try:
            brukerinput = int(input("Velg et valg: "))
            if brukerinput < 0 or brukerinput >= len(valgmuligheter):
                print("Ugyldig valg")
            else:
                return brukerinput
        except ValueError:
            print("Ugyldig valg")

# Hovedfunksjon
def main():
    conn = connect_to_db() # Koble til databasen
    print("\n ==== Velkommen til flyplassinformasjonssystemet ===")

    # Henter flyplasser fra databasen
    flyplasser = get_airports(conn)
    flyplasser_valg = [f"{kode} - {navn}" for kode, navn in flyplasser]

    print("\nVelg flyplass:")
    flyplass_valg = meny(flyplasser_valg)
    valgt_flyplass_kode = flyplasser[flyplass_valg][0]

    # Henter ukedager
    ukedager = ['Mandag', 'Tirsdag', 'Onsdag', 'Torsdag', 'Fredag', 'Lørdag', 'Søndag']
    print("\nVelg ukedag:")
    ukedag_valg = meny(ukedager)
    valgt_ukedag = ukedager[ukedag_valg]

    # Henter retning
    retning_alternativer = ['Avgang', 'Ankomst']
    print("\nVelg retning (Avgang (0) /Ankomst (1)):")
    retning_valg = meny(retning_alternativer)
    valgt_retning = retning_alternativer[retning_valg]

    # Hente og skrive ut fly timeplan for valgt flyplass, ukedag og retning
    fly_timeplan = get_flight_schedule(conn, valgt_flyplass_kode, valgt_ukedag, valgt_retning)

    if not fly_timeplan: # Hvis det ikke finnes noen flyvninger
        print("Ingen flyavganger funnet")
    else:
        print(f"\n{valgt_retning}er for {valgt_flyplass_kode} på {valgt_ukedag}:")
        print("-" * 80)


        if valgt_retning == 'Avgang':
            print(f"{'Rute':<8} {'Til':<6} {'Avgang':<10} {'Ankomst':<10} {'Dager':<20} {'Selskap':<6} {'Flytype':<15}")
        else:
            print(f"{'Rute':<8} {'Fra':<6} {'Avgang':<10} {'Ankomst':<10} {'Dager':<20} {'Selskap':<6} {'Flytype':<15}")
        
        print("-" * 80)

        for fly in fly_timeplan:
            rute, fra, til, avgang, ankomst, ukedagskode, selskap, flytype = fly   
            if valgt_retning == 'Avgang':
                print(f"{rute:<8} {til:<6} {avgang:<10} {ankomst:<10} {valgt_ukedag:<20} {selskap:<6} {flytype:<15}")
            else:
                print(f"{rute:<8} {fra:<6} {avgang:<10} {ankomst:<10} {valgt_ukedag:<20} {selskap:<6} {flytype:<15}")

    # Avslutte databasetilkobling
    conn.close()

if __name__ == '__main__':
    main()