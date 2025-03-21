-- Finner flyselskap, hvilke flytyper de bruker og antall fly per flytype
SELECT 
    fs.Kode AS Flyselskapkode, 
    fs.Navn AS Flyselskapnavn, 
    f.Flytype, 
    COUNT(f.Registreringsnummer) AS AntallFly
FROM 
    Flyselskap fs
JOIN 
    Flyrute fr ON fs.Kode = fr.Flyselskap
JOIN 
    Fly f ON fr.Flytype = f.Flytype
GROUP BY 
    fs.Kode, fs.Navn, f.Flytype
ORDER BY 
    fs.Navn, f.Flytype;