-- Imer Kozhani YH24

--  Skapar databasen för "Bokhandel"
CREATE DATABASE Bokhandel;
USE Bokhandel;

-- Skapar tabellen för "Kunder"
-- VARCHAR innebär antal tecken som finns 
CREATE TABLE Kunder (
    KundID INT PRIMARY KEY AUTO_INCREMENT,
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(100) NOT NULL UNIQUE,
    Telefon VARCHAR(20),
    Adress VARCHAR(200)
);

-- Skapar tabellen för "Böcker"
-- ISBN är ett unikt ID för böcker såsom exempelvis personnummer.
-- ISBN (20) max antal siffror
CREATE TABLE Böcker (
    ISBN VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(150) NOT NULL,
    Författare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10, 2) NOT NULL CHECK (Pris > 0),
    Lagerstatus INT NOT NULL
);

-- Skapar tabellen för "Beställningar"
CREATE TABLE Beställningar (
    Ordernummer INT PRIMARY KEY AUTO_INCREMENT,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Totalbelopp DECIMAL(10, 2) NOT NULL,
    KundID INT, FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);


--  Skapar tabellen för "Orderrader"
CREATE TABLE Orderrader (
    OrderradID INT PRIMARY KEY AUTO_INCREMENT,
    Ordernummer INT,
    ISBN VARCHAR(20),
    Antal INT NOT NULL,
    FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN)
);



-- 1.
-- Infogar Data i "Kunder"
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Lisa Svensson', 'lisa@gmail.com', '0701234567', 'Storgatan 1, Stockholm'),
('David Johansson', 'david@hotmail.com', '0707654321', 'Lillgatan 5, Malmö'),
('Lukas Olsson', 'lukas@gmail.com', '0726356654', 'Lybecksvägen 12, Kalmar'),
('Ivar Karlsson', 'ivar@hotmail.com', '0707654561', 'Lillgatan 20, Malmö');


-- Infogar Data i "Böcker"
INSERT INTO Böcker (ISBN, Titel, Författare, Pris, Lagerstatus) VALUES
("9780140309577", "Pippi longstocking", "Astrid Lindgren", 259.99, 15),
("9780439023481", "The Hunger Games", "Suzanne Collins", 199.99, 5),
("9780553573404", "A Game of Thrones", "George R.R. Martin", 299.99, 10);

-- Infogar Data i "Beställningar"
INSERT INTO Beställningar (KundID, Datum, Totalbelopp) VALUES
(1, '2025-03-10', 299.99), 
(2, '2025-03-10', 259.99), 
(3, '2025-03-21', 259.99),
(3, '2025-03-21', 199.99),
(3, '2025-03-21', 299.99);



-- Infogar Data i "Orderrader"
INSERT INTO Orderrader (Ordernummer, ISBN, Antal) VALUES
(1, "9780553573404", 1),
(2, "9780140309577", 2),
(3, "9780140309577", 4),
(4, "9780439023481", 2),
(5, "9780553573404", 2);



-- 2.

-- Visar allt från tabellen böcker
SELECT * FROM Böcker;


-- Visar alla "Kunder" och "Beställningar"
SELECT * FROM Kunder;
SELECT * FROM Beställningar;


-- Filtrera Kunder baserat på "Namn" och "Epost"
SELECT * FROM Kunder WHERE Namn = 'Lisa Svensson';
SELECT * FROM Kunder WHERE Epost LIKE '%@hotmail.com';
SELECT * FROM Kunder WHERE Namn LIKE 'L%';

-- Sortera produkter efter pris, dyrast först
SELECT * FROM Böcker ORDER BY Pris DESC;

-- Sortera produkter efter pris, billigast först
SELECT * FROM Böcker ORDER BY Pris ASC;

-- 3.
-- Uppdatera en kunds e-postadress
UPDATE Kunder SET Epost = 'lisa.svensson@yahoo.com' WHERE Namn = "Lisa Svensson";

-- Tar bort en specifik kund 
DELETE FROM Kunder WHERE Namn = 'David Johansson';

-- Återställer raderad Data
ROLLBACK; 



-- 4.
-- INNER JOIN – Kunder som har beställningar
SELECT Kunder.Namn, Beställningar.Ordernummer, Beställningar.Totalbelopp 
FROM Kunder
INNER JOIN Beställningar ON Kunder.KundID = Beställningar.KundID;

-- LEFT JOIN – Visa alla kunder, även de utan beställningar
SELECT Kunder.Namn, Beställningar.Ordernummer
FROM Kunder
LEFT JOIN Beställningar ON Kunder.KundID = Beställningar.KundID;

-- GROUP BY – Antal beställningar per kund
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID;

-- HAVING – Visa kunder med fler än 2 beställningar
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar 
FROM Beställningar 
GROUP BY KundID 
HAVING COUNT(Ordernummer) > 2;



-- 5.
-- Index för snabbare sökningar på e-post
CREATE INDEX idx_email ON Kunder (Epost);


-- Trigger - Minska lagersaldo när en beställning görs
CREATE TRIGGER minska_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
UPDATE Böcker SET Lagerstatus = Lagerstatus - NEW.Antal WHERE ISBN = NEW.ISBN;

-- Skapae tabellen för "Logg"
CREATE TABLE Logg (
    LoggID INT PRIMARY KEY AUTO_INCREMENT,
    Meddelande TEXT,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KundID INT,  -- KundID som en främmande nyckel
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) -- Skapar relationen till Kunder
);

-- Trigger - Logga när en ny kund registreras
CREATE TRIGGER logg_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
INSERT INTO Logg (Meddelande, KundID) VALUES (CONCAT('Ny kund registrerad: ', NEW.Namn), NEW.KundID);

-- 6

-- Backup av databasen, TERMINAL!
-- mysqldump -u root -p Bokhandel > bokhandel_backup.sql

-- Återställ databasen från backup
-- mysql -u root -p Bokhandel < bokhandel_backup.sql



 

