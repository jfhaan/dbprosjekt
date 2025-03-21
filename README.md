# TDT4145 - Gruppe33

I denne repoen vil du finne våre løsninger til prosjektet i emnet TDT4145.

## Initialisering

For å opprette en database `fly.db`, lage tables og å fylle den med data fra oppgave 1-4 og 7 kjør:

```python3
python3 init.py
```

## Oppgaver

### Oppgave 5

```python3
python3 oppgave5.py
```

### Oppgave 6

```python3
python3 oppgave6.py
```

## Oppgave 7

For å sjekke det har blitt lagt til bestillinger kan man kjøre følgende i terminalen

```sql
sqlite3 fly.db
```

```sql
SELECT *
FROM Bestilling
WHERE kundenumer = 1;
```

### Oppgave 8

```python3
python3 oppgave8.py
```
