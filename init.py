import sqlite3


# Read and execute SQL script
def execute(cursor, sql_script):
    try:
        with open(sql_script, "r") as file:
            sql_script_content = file.read()
        cursor.executescript(sql_script_content)
        print(f"Successfully executed {sql_script}")
    except Exception as e:
        print(f"Error executing SQL script: {e}")


def main():
    conn = sqlite3.connect("fly.db")
    c = conn.cursor()

    execute(c, "schema.sql")

    execute(c, "oppgave1.sql")
    execute(c, "oppgave2.sql")
    execute(c, "oppgave3.sql")
    execute(c, "oppgave4.sql")

    execute(c, "oppgave7.sql")

    conn.commit()
    conn.close()


if __name__ == "__main__":
    main()
