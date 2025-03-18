-- Brukstilfelle 1: Registrere flyplass --
INSERT INTO Flyplass (Kode, Navn)
VALUES ('BOO', 'Bodø Lufthavn');

INSERT INTO Flyplass (Kode, Navn)
VALUES ('BGO', 'Bergen Lufthavn, Flesland');

INSERT INTO Flyplass (Kode, Navn)
VALUES ('OSL', 'Oslo Lufthavn, Gardermoen');

INSERT INTO Flyplass (Kode, Navn)
VALUES ('SVG', 'Stavanger Lufthavn, Sola');

INSERT INTO Flyplass (Kode, Navn)
VALUES ('TRD', 'Trondheim Lufthavn, Værnes');

-- Brukstilfelle 2.1: Registrere flyselskap --
INSERT INTO Flyselskap (Kode, Navn)
VALUES ('DY', 'Norwegian');

INSERT INTO Flyselskap (Kode, Navn)
VALUES ('SK', 'SAS');

INSERT INTO  Flyselskap (Kode, Navn)
VALUES ('WF', 'Widerøe');

-- Brukstilfelle 2.2: Registrere flytype --

-- Registrere data for flyprodusent --
INSERT INTO Flyprodusent (Navn, Stiftelsesaar)
VALUES ('The Boeing Company', 1916);
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('USA', 'The Boeing Company');

INSERT INTO Flyprodusent (Navn, Stiftelsesaar)
VALUES ('Airbus Group', 1970);
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('Frankrike', 'Airbus Group');
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('Tyskland', 'Airbus Group');
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('Spania', 'Airbus Group');
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('Storbritannia', 'Airbus Group');

INSERT INTO Flyprodusent (Navn, Stiftelsesaar)
VALUES ('De Havilland Canada', 1928);
INSERT INTO FlyprodusentNasjonalitet(Nasjonalitet, Flyprodusent)
VALUES ('Canada', 'De Havilland Canada');

-- Registrere data for flytype --
INSERT INTO Flytype (Navn, Flyprodusent, Produksjonsstart, Produksjonsslutt)
VALUES ('Boeing 737 800', 'The Boeing Company', '1997-01-01', '2020-01-01');

INSERT INTO Flytype (Navn, Flyprodusent, Produksjonsstart, Produksjonsslutt)
VALUES ('Airbus a320neo', 'Airbus Group', '2016-01-01', NULL);

INSERT INTO Flytype (Navn, Flyprodusent, Produksjonsstart, Produksjonsslutt)
VALUES ('Dash-8 100', 'De Havilland Canada', '1984-01-01', '2005-01-01');

-- Registrere kabinkonfigurasjon --
-- Boeing 737 800 --
-- Bruker rekursiv CTE for å generere seterader og seter
-- for flytypen Boeing 737 800
WITH RECURSIVE 
  rows(r) AS (
    SELECT 1
    UNION ALL
    SELECT r + 1 FROM rows WHERE r < 31
  ),
  seats(letter) AS (
    SELECT 'A' UNION ALL
    SELECT 'B' UNION ALL
    SELECT 'C' UNION ALL
    SELECT 'D' UNION ALL
    SELECT 'E' UNION ALL
    SELECT 'F'
  )
INSERT INTO Sete (Rad, Plass, Flytype)
SELECT r, letter, 'Boeing 737 800'
FROM rows, seats;

-- Nødutgangsrad for Boeing 737 800 --
INSERT INTO Noedutgangrad (Flytype, Seterad)
VALUES ('Boeing 737 800', 13);

-- Airbus a320neo --
-- Bruker rekursiv CTE for å generere seterader og seter
-- for flytypen Airbus a320neo
WITH RECURSIVE 
  rows(r) AS (
    SELECT 1
    UNION ALL
    SELECT r + 1 FROM rows WHERE r < 30
  ),
  seats(letter) AS (
    SELECT 'A' UNION ALL
    SELECT 'B' UNION ALL
    SELECT 'C' UNION ALL
    SELECT 'D' UNION ALL
    SELECT 'E' UNION ALL
    SELECT 'F'
  )
INSERT INTO Sete (Rad, Plass, Flytype)
SELECT r, letter, 'Airbus a320neo'
FROM rows, seats;

-- Nødutgangsrad for Airbus a320neo --
INSERT INTO Noedutgangrad (Flytype, Seterad)
VALUES ('Airbus a320neo', 11),
       ('Airbus a320neo', 12);

-- Dash-8 100 --
-- Oppretter rad 1 --
INSERT INTO Sete (Rad, Plass, Flytype)
VALUES (1, 'C', 'Dash-8 100'),
       (1, 'D', 'Dash-8 100');

-- Oppretter rad 2 -10 --
-- Bruker rekursiv CTE for å generere seterader og seter
WITH RECURSIVE 
  rows(r) AS (
    SELECT 2
    UNION ALL
    SELECT r + 1 FROM rows WHERE r < 10
  ),
  seats(letter) AS (
    SELECT 'A' UNION ALL
    SELECT 'B' UNION ALL
    SELECT 'C' UNION ALL
    SELECT 'D'
  )
INSERT INTO Sete (Rad, Plass, Flytype)
SELECT r, letter, 'Dash-8 100'
FROM rows, seats;

-- Nøduutgangsrad for Dash-8 100 --
INSERT INTO Noedutgangrad (Flytype, Seterad)
VALUES ('Dash-8 100', 5);

-- Brukstilfelle 2.3: Registrere fly --
-- Norwegian --
INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyproduset)
VALUES ('LN-ENU', '42069', NULL, '2015-01-01', 'Boeing 737 800', 'The Boeing Company');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-ENR', '42093', 'Jan Bålsrud', '2018-01-01', 'Boeing 737 800', 'The Boeing Company');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-NIQ', '39403', 'Max Manus', '2011-01-01', 'Boeing 737 800', 'The Boeing Company');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-ENS', '42281', NULL, '2017-01-01', 'Boeing 737 800', 'The Boeing Company');

-- SAS --
INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('SE-RUB', '9518', 'Birger Viking', '2020-01-01', 'Airbus a320neo', 'Airbus Group');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('SE-DIR', '11421', 'Nora Viking', '2023-01-01', 'Airbus a320neo', 'Airbus Group');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('SE-RUP', '12066', 'Ragnhild Viking', '2024-01-01', 'Airbus a320neo', 'Airbus Group');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('SE-RZE', '12166', 'Ebbe Viking', '2024-01-01', 'Airbus a320neo', 'Airbus Group');

-- Widerøe --
INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-WIH', '383', 'Oslo', '1994-01-01', 'Dash-8 100', 'De Havilland Canada');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-WIA', '359', 'Nordland', '1993-01-01', 'Dash-8 100', 'De Havilland Canada');

INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
VALUES ('LN-WIL', '298', 'Narvik', '1995-01-01', 'Dash-8 100', 'De Havilland Canada');






