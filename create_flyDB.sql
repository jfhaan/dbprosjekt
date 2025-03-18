-- Oppretter Flyprodusent-tabellen først siden andre tabeller refererer til den
CREATE TABLE Flyprodusent (
    Navn VARCHAR(100) PRIMARY KEY,
    Nasjonalitet VARCHAR(100) NOT NULL,
    Stiftelsesaar INTEGER NOT NULL
);

-- Oppretter Flytype-tabellen som refererer til Flyprodusent
CREATE TABLE Flytype (
    Navn VARCHAR(100) PRIMARY KEY,
    Flyprodusent VARCHAR(100) NOT NULL,
    Produksjonsstart DATE NOT NULL,
    Produksjonsslutt DATE,
    FOREIGN KEY (Flyprodusent) REFERENCES Flyprodusent (Navn)
);

-- Oppretter Fly-tabellen
CREATE TABLE Fly (
    Registreringsnummer VARCHAR(20) PRIMARY KEY,
    Serienummer VARCHAR(50) NOT NULL,
    Navn VARCHAR(100),
    Driftsstart DATE NOT NULL,
    Flytype VARCHAR(100) NOT NULL,
    Flyprodusent VARCHAR(100) NOT NULL,
    FOREIGN KEY (Flytype) REFERENCES Flytype (Navn),
    FOREIGN KEY (Flyprodusent) REFERENCES Flyprodusent (Navn),
    UNIQUE (Serienummer, Flyprodusent)
);

-- Oppretter Sete-tabellen
CREATE TABLE Sete (
    Rad INTEGER,
    Plass CHAR(1),
    Flytype VARCHAR(100),
    PRIMARY KEY (Rad, Plass, Flytype),
    FOREIGN KEY (Flytype) REFERENCES Flytype (Navn)
);

-- Oppretter Nødutgangrad-tabellen
CREATE TABLE Noedutgangrad (
    Flytype VARCHAR(100),
    Seterad INTEGER,
    PRIMARY KEY (Flytype, Seterad),
    FOREIGN KEY (Flytype) REFERENCES Flytype (Navn),
    FOREIGN KEY (Seterad) REFERENCES Sete (Rad)
);

-- Oppretter Flyselskap-tabellen
CREATE TABLE Flyselskap (
    Kode VARCHAR(10) PRIMARY KEY,
    Navn VARCHAR(100) NOT NULL
);

-- Oppretter Flyplass-tabellen
CREATE TABLE Flyplass (
    Kode VARCHAR(10) PRIMARY KEY,
    Navn VARCHAR(100) NOT NULL
);

-- Oppretter Flyrute-tabellen
CREATE TABLE Flyrute (
    Flyrutenummer VARCHAR(20) PRIMARY KEY,
    Ukedagskode VARCHAR(7) NOT NULL,
    Flyselskap VARCHAR(10) NOT NULL,
    Flytype VARCHAR(100) NOT NULL,
    FOREIGN KEY (Flyselskap) REFERENCES Flyselskap (Kode),
    FOREIGN KEY (Flytype) REFERENCES Flytype (Navn)
);

-- Oppretter RuteStrekning-tabellen
CREATE TABLE RuteStrekning (
    Id INTEGER PRIMARY KEY,
    Flyrutenummer VARCHAR(20) NOT NULL,
    PlanlagtAvgang TIMESTAMP NOT NULL,
    PlanlagtAnkomst TIMESTAMP NOT NULL,
    Startflyplass VARCHAR(10) NOT NULL,
    Sluttflyplass VARCHAR(10) NOT NULL,
    FOREIGN KEY (Flyrutenummer) REFERENCES Flyrute (Flyrutenummer),
    FOREIGN KEY (Startflyplass) REFERENCES Flyplass (Kode),
    FOREIGN KEY (Sluttflyplass) REFERENCES Flyplass (Kode)
);

-- Oppretter Strekningspris-tabellen
CREATE TABLE Strekningspris (
    RuteStrekningId INTEGER,
    Kategori VARCHAR(10) CHECK (Kategori IN ('budsjett', 'økonomi', 'premium')),
    Pris DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (RuteStrekningId, Kategori),
    FOREIGN KEY (RuteStrekningId) REFERENCES RuteStrekning (Id)
);

-- Oppretter Flyvning-tabellen
CREATE TABLE Flyvning (
    Loepenummer INTEGER PRIMARY KEY,
    RuteStrekningId INTEGER NOT NULL,
    FlyvningStatus VARCHAR(50) CHECK (
        FlyvningStatus IN ('planned', 'active', 'completed', 'cancelled')
    ),
    FaktiskAvgang TIMESTAMP,
    FaktiskAnkomst TIMESTAMP,
    Fly VARCHAR(20) NOT NULL,
    FOREIGN KEY (RuteStrekningId) REFERENCES RuteStrekning (Id),
    FOREIGN KEY (Fly) REFERENCES Fly (Registreringsnummer)
);

-- Oppretter Billett-tabellen
CREATE TABLE Billett (
    Id INTEGER PRIMARY KEY,
    Referansenummer VARCHAR(50) NOT NULL,
    Kategori VARCHAR(10) CHECK (Kategori IN ('budsjett', 'økonomi', 'premium')),
    Pris DECIMAL(10, 2) NOT NULL,
    Innsjekkingstid TIMESTAMP NOT NULL,
    Sete VARCHAR(10) NOT NULL,
    Flyvning INTEGER NOT NULL,
    FOREIGN KEY (Flyvning) REFERENCES Flyvning (Loepenummer),
    FOREIGN KEY (Referansenummer) REFERENCES Bestilling (Referansenummer)
);

-- Oppretter Kunde-tabellen
CREATE TABLE Kunde (
    Kundenummer INTEGER PRIMARY KEY,
    Navn VARCHAR(100) NOT NULL,
    Telefonnummer VARCHAR(20) NOT NULL,
    Epostadresse VARCHAR(100) NOT NULL,
    Nasjonalitet VARCHAR(50) NOT NULL,
    Fordelsprogramref VARCHAR(50)
);

-- Oppretter Bestilling-tabellen
CREATE TABLE Bestilling (
    Referansenummer VARCHAR(50) PRIMARY KEY,
    Totalpris DECIMAL(10, 2) NOT NULL,
    Kundenummer INTEGER NOT NULL,
    FOREIGN KEY (Kundenummer) REFERENCES Kunde (Kundenummer),
);

-- Oppretter Bagasje-tabellen
CREATE TABLE Bagasje (
    Registreringsnummer VARCHAR(50) PRIMARY KEY,
    Vekt DECIMAL(5, 2) NOT NULL,
    Innleveringstidspunkt TIMESTAMP,
    Billett INTEGER NOT NULL,
    FOREIGN KEY (Billett) REFERENCES Billett (Id)
);

-- Oppretter OperererFlytype-tabellen
CREATE TABLE OperererFlytype (
    Flyselskapskode VARCHAR(10),
    Flytype VARCHAR(100),
    PRIMARY KEY (Flyselskapskode, Flytype),
    FOREIGN KEY (Flyselskapskode) REFERENCES Flyselskap (Kode),
    FOREIGN KEY (Flytype) REFERENCES Flytype (Navn)
);

