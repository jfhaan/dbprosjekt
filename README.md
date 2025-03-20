# TDT4145 - Gruppe33

I denne repoen vil du finne våre løsninger til prosjektet i emnet TDT4145.

## Initialisering

Under kommer det en stegvis forklaring på hvordan prosjektet skal kjøres.

1. Opprette databasen
   I terminalen skriv

   ```sqlite3
   sqlite3 fly.db
   ```

   Dette vil opprette en fil med navn fly.db

2. Legge inn data
   Skriv følgende kode i terminalen

   ```sqlite3
   .read create_flyDB.sql
   ```

   Dette vil opprette en database basert på koden i

   ```sqlite3
   create_flyDB.sql
   ```

3. Legge inn data
   For å legge inn data i databasen, skriv følgende kommando i terminalen

   ```sqlite3
   .read data.sql
   ```

## Oppgaver

## Oppgave 5

For å kjøre opppgave6, kan du skrive i terminalen

```sqlite3
   .read queries.sql
```

### Oppgave 6

For å kjøre opppgave6, kan du skrive i terminalen

```python
   python3 oppgave6.py
```
