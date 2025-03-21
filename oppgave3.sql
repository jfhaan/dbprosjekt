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
