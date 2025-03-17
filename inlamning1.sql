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
-- ISBN (13) max antal siffror
CREATE TABLE Böcker (
    ISBN VARCHAR(13) PRIMARY KEY,
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
    ISBN VARCHAR(13),
    Antal INT NOT NULL,
    Pris DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN)
);

-- Infogar Data i "Kunder"
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Lisa Svensson', 'lisa@gmail.com', '0701234567', 'Storgatan 1, Stockholm'),
('David Johansson', 'david@hotmail.com', '0707654321', 'Lillgatan 5, Malmö');


-- Infogar Data i "Böcker"
INSERT INTO Böcker (ISBN, Titel, Författare, Pris, Lagerstatus) VALUES
("9780140309577", "Pippi longstocking", "Astrid Lindgren", 259.99, 15),
("9780439023481", "The Hunger Games", "Suzanne Collins", 199.99, 5);

-- Infogar Data i "Beställningar"
INSERT INTO Beställningar (KundID, Datum, Totalbelopp) VALUES
(1, '2025-03-10', 299.49), (2, '2025-03-10', 499.49);

-- Infogar Data i "Orderrader"
INSERT INTO Orderrader (Ordernummer, ISBN, Antal, Pris) VALUES
(1, "9780140309577", 1, 259.99),
(1, "9780439023481", 1, 199.99);


-- Visar allt från tabellen kunder där enbart namnet Lisa svensson dyker upp
SELECT * FROM Kunder WHERE Namn = "Lisa Svensson";

-- Visar allt från tabellen böcker
SELECT * FROM Böcker;


 

