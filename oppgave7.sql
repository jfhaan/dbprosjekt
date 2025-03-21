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

