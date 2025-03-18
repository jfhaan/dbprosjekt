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

