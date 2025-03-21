import sqlite3


# Read and execute SQL script
def execute(cursor, sql_script):
    try:
        with open(sql_script, "r") as file:
            sql_script_content = file.read()
        cursor.execute(sql_script_content)
        print(f"Successfully executed {sql_script}")
    except Exception as e:
        print(f"Error executing SQL script: {e}")


def main():
    conn = sqlite3.connect("fly.db")
    c = conn.cursor()

    execute(c, "oppgave5.sql")
    res = c.fetchall()
    print()
    print("Selskapskode | Selskapsnavn | Type | Antall")
    for tup in res:
        print(" | ".join(map(str, tup)))

    conn.commit()
    conn.close()


if __name__ == "__main__":
    main()
