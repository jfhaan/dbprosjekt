-- Oppgave 1: Registrere flyplass --
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

-- Oppgave 2.1: Registrere flyselskap --
INSERT INTO Flyselskap (Kode, Navn)
VALUES ('DY', 'Norwegian');

INSERT INTO Flyselskap (Kode, Navn)
VALUES ('SK', 'SAS');

INSERT INTO  Flyselskap (Kode, Navn)
VALUES ('WF', 'Widerøe');

-- Oppgave 2.2: Registrere flytype --

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

-- Oppretter rad 2 - 10 --
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

-- Oppgave 2.3: Registrere fly --
-- Norwegian --
INSERT INTO Fly (Registreringsnummer, Serienummer, Navn, Driftsstart, Flytype, Flyprodusent)
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

-- Oppgave 3 --
-- Første flyrute --
INSERT INTO Flyrute (Flyrutenummer, Ukedagskode, Flyselskap, Flytype)
VALUES ('WF1311', '12345', 'WF', 'Dash-8 100');
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (1, 'WF1311', '15:15:00', '16:20:00', 'TRD', 'BOO');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (1, 'premium', 2018.00),
       (1, 'økonomi', 899.00),
       (1, 'budsjett', 599.00);

-- Andre flyrute
INSERT INTO Flyrute (Flyrutenummer, Ukedagskode, Flyselskap, Flytype)
VALUES ('WF1302', '12345', 'WF', 'Dash-8 100');
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (2, 'WF1302', '07:35:00', '08:40:00', 'BOO', 'TRD');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (2, 'premium', 2018.00),
       (2, 'økonomi', 899.00),
       (2, 'budsjett', 599.00);

-- Tredje flyrute --
INSERT INTO Flyrute (Flyrutenummer, Ukedagskode, Flyselskap, Flytype)
VALUES ('DY753', '1234567', 'DY', 'Boeing 737 800');
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (3, 'DY753', '10:20:00', '11:15:00', 'TRD', 'OSL');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (3, 'premium', 1500.00),
       (3, 'økonomi', 1000.00),
       (3, 'budsjett', 500.00);

-- Fjerde flyrute --
INSERT INTO Flyrute (Flyrutenummer, Ukedagskode, Flyselskap, Flytype)
VALUES ('SK332', '1234567', 'SK', 'Airbus a320neo');
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (4, 'SK332', '08:00:00', '09:05:00', 'OSL', 'TRD');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (4, 'premium', 1500.00),
       (4, 'økonomi', 1000.00),
       (4, 'budsjett', 500.00);

-- Femte flyrute --
INSERT INTO Flyrute (Flyrutenummer, Ukedagskode, Flyselskap, Flytype)
VALUES ('SK888', '12345', 'SK', 'Airbus a320neo');
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (5, 'SK888', '10:00:00', '11:10:00', 'TRD', 'BGO');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (5, 'premium', 2000.00),
       (5, 'økonomi', 1500.00),
       (5, 'budsjett', 800.00);
    
INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (6, 'SK888', '11:40:00', '12:10:00', 'BGO', 'SVG');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (6, 'premium', 1000.00),
       (6, 'økonomi', 700.00),
       (6, 'budsjett', 350.00);

INSERT INTO RuteStrekning(Id, Flyrutenummer, PlanlagtAvgang, PlanlagtAnkomst, Startflyplass, Sluttflyplass)
VALUES (7, 'SK888', '10:00:00', '12:10:00', 'TRD', 'SVG');
INSERT INTO Strekningspris(RuteStrekningId, Kategori, Pris)
VALUES (7, 'premium', 2200.00),
       (7, 'økonomi', 1700.00),
       (7, 'budsjett', 1000.00);

-- Oppgave 4 -- 
INSERT INTO Flyvning(Loepenummer, RuteStrekningId, FlyvningStatus, FaktiskAvgang, FaktiskAnkomst, Fly)
VALUES ('WF1302 01APR2025', 1, 'planned', '2025-04-01 15:15:00', '2025-04-01 16:20:00', 'LN-WIH'),
       ('DY753 01APR2025', 3 , 'planned', '2025-04-01 10:20:00', '2025-04-01 11:15:00', 'LN-ENU'),
       ('SK888 01APR2025', 5 , 'planned', '2025-04-01 10:00:00', '2025-04-01 11:10:00', 'SE-RUB'),
       ('SK888 01APR2025', 6 , 'planned', '2025-04-01 11:40:00', '2025-04-01 12:10:00', 'SE-RUB'),
       ('SK888 01APR2025', 7 , 'planned', '2025-04-01 10:00:00', '2025-04-01 12:10:00', 'SE-RUB');

-- Oppgave 5 --
-- Spørringen ligger i queries.sql --

-- Oppgave 7 --
-- Opprette én kunde -- 
INSERT INTO Kunde (Kundenummer, Navn, Telefonnummer, Epostadresse, Nasjonalitet, Fordelsprogramref)
VALUES (1, 'Ola Nordmann', '12345678', 'Ola@nordmann.no', 'Norge', 'ABCDEF');

-- BESTILLING 1 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-001',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (1, 'WF1302-20250401-001', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '1C', 'WF1302 01APR2025'); 

-- BESTILLING 2 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-002',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'premium'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (2, 'WF1302-20250401-002', 'premium', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'premium'),
      '2025-04-01 06:30:00', '1D', 'WF1302 01APR2025'); 

-- BESTILLING 3 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-003',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (3, 'WF1302-20250401-003', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '2A', 'WF1302 01APR2025'); 

-- BESTILLING 4 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-004',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (4, 'WF1302-20250401-003', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '2B', 'WF1302 01APR2025'); 

-- BESTILLING 5 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-005',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (5, 'WF1302-20250401-005', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '2C', 'WF1302 01APR2025'); 

-- BESTILLING 6 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-006',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (6, 'WF1302-20250401-006', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '2D', 'WF1302 01APR2025'); 

-- BESTILLING 7 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-007',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (7, 'WF1302-20250401-007', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '3A', 'WF1302 01APR2025'); 

-- BESTILLING 8 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-008',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (8, 'WF1302-20250401-008', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '3B', 'WF1302 01APR2025'); 

-- BESTILLING 9 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-009',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (9, 'WF1302-20250401-009', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '3C', 'WF1302 01APR2025'); 

-- BESTILLING 10 --
INSERT INTO Bestilling(Referansenummer, Totalpris, Kundenummer)
VALUES ('WF1302-20250401-010',
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),  
      1);
INSERT INTO Billett (id, Referansenummer, Kategori, Pris, Innsjekkingstid, Sete, Flyvning)
VALUES (10, 'WF1302-20250401-010', 'økonomi', 
      (SELECT Pris FROM Strekningspris WHERE RuteStrekningId = 2 AND Kategori = 'økonomi'),
      '2025-04-01 06:30:00', '3D', 'WF1302 01APR2025'); 