-- DROP EXISTING TABLES
-- Remove tables if they exist. CASCADE ensures that dependent objects, such as foreign keys, are also dropped.
DROP TABLE IF EXISTS Sales CASCADE;
DROP TABLE IF EXISTS Paintings CASCADE;
DROP TABLE IF EXISTS Artists CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS ZipCodes CASCADE;

-- CREATE TABLES

-- Table: ZipCodes
-- Stores zip codes and their corresponding cities. Each zip code uniquely identifies a city.
-- Normalization:
-- - 1NF: Atomic columns (`ZipCode`, `City`).
-- - 2NF: `City` depends fully on `ZipCode` (the primary key).
-- - 3NF/BCNF: No transitive dependencies; `City` depends directly on `ZipCode`.
CREATE TABLE ZipCodes (
    ZipCode VARCHAR(10) PRIMARY KEY, -- Unique identifier for each city
    City VARCHAR(50)                -- City name corresponding to the zip code
);

-- Table: Customers
-- Stores customer information, including their address and associated zip code.
-- Normalization:
-- - 1NF: Atomic columns (e.g., `FirstName`, `LastName`).
-- - 2NF: All attributes depend fully on `CustomerID`.
-- - 3NF/BCNF: `City` is stored in `ZipCodes`, avoiding transitive dependencies via `ZipCode`.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,         -- Unique identifier for each customer
    FirstName VARCHAR(50),              -- Customer's first name
    LastName VARCHAR(50),               -- Customer's last name
    Phone VARCHAR(20),                  -- Customer's phone number
    Street VARCHAR(100),                -- Street address of the customer
    ZipCode VARCHAR(10),                -- Associated zip code (foreign key)
    FOREIGN KEY (ZipCode) REFERENCES ZipCodes(ZipCode) -- Ensures valid zip codes
);

-- Table: Artists
-- Stores information about artists who create paintings.
-- Normalization:
-- - 1NF: Atomic columns (e.g., `ArtistName`).
-- - 2NF: All attributes depend fully on `ArtistID`.
-- - 3NF/BCNF: No transitive dependencies; all attributes directly depend on `ArtistID`.
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,           -- Unique identifier for each artist
    ArtistCode VARCHAR(10),             -- Code representing the artist
    ArtistName VARCHAR(100)             -- Name of the artist
);

-- Table: Paintings
-- Stores information about paintings, including the artist who created each.
-- Normalization:
-- - 1NF: Atomic columns (e.g., `Title`).
-- - 2NF: All attributes depend fully on `PaintingID`.
-- - 3NF/BCNF: No transitive dependencies; `ArtistName` is not repeated here.
CREATE TABLE Paintings (
    PaintingID INT PRIMARY KEY,         -- Unique identifier for each painting
    ArtistID INT,                       -- Foreign key referencing the artist who created the painting
    PaintingCode VARCHAR(10),           -- Code representing the painting
    Title VARCHAR(100),                 -- Title of the painting
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) -- Ensures valid artist references
);

-- Table: Sales
-- Stores information about the sale of paintings, including the customer, painting, and sale details.
-- Normalization:
-- - 1NF: Atomic columns (e.g., `SalePrice`).
-- - 2NF: All attributes depend fully on `SaleID`.
-- - 3NF/BCNF: No transitive dependencies; painting and customer details are referenced via foreign keys.
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,             -- Unique identifier for each sale
    CustomerID INT,                     -- Foreign key referencing the customer making the purchase
    PaintingID INT,                     -- Foreign key referencing the painting being sold
    SaleDate DATE,                      -- Date of the sale
    SalePrice DECIMAL(10, 2),           -- Price at which the painting was sold
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Ensures valid customer references
    FOREIGN KEY (PaintingID) REFERENCES Paintings(PaintingID), -- Ensures valid painting references
    UNIQUE (PaintingID, SaleDate)       -- Ensures each painting can only be sold once on a given date
);

-- DATA INSERTION

-- Insert into ZipCodes
-- Populate the ZipCodes table with an example entry.
INSERT INTO ZipCodes (ZipCode, City) 
VALUES ('L3J 4S4', 'Fonthill');

-- Insert into Customers
-- Populate the Customers table with a single customer who resides in the `ZipCode` defined above.
INSERT INTO Customers (CustomerID, FirstName, LastName, Phone, Street, ZipCode)
VALUES (1, 'Elizabeth', 'Jackson', '(206) 284-6783', '123 – 4th Avenue', 'L3J 4S4');

-- Insert into Artists
-- Populate the Artists table with two artists and their respective details.
INSERT INTO Artists (ArtistID, ArtistCode, ArtistName) 
VALUES 
(1, '03', 'Carol Channing'),
(2, '15', 'Dennis Frings');

-- Insert into Paintings
-- Populate the Paintings table with three paintings created by the artists defined above.
INSERT INTO Paintings (PaintingID, ArtistID, PaintingCode, Title) 
VALUES
(1, 1, 'P1', 'Laugh with Teeth'),
(2, 2, 'P2', 'Toward Emerald Sea'),
(3, 1, 'P9', 'At the Movies');

-- Insert into Sales
-- Record sales transactions, including the painting, customer, sale date, and price.
-- Example includes a sale that repeats the painting with a different sale date.
INSERT INTO Sales (SaleID, CustomerID, PaintingID, SaleDate, SalePrice) 
VALUES
(1, 1, 1, '2000-09-17', 7000.00),
(2, 1, 2, '2000-05-11', 1800.00),
(3, 1, 3, '2002-02-14', 5550.00),
(4, 1, 2, '2003-07-15', 2200.00);

-- DATA RETRIEVAL
-- Retrieve all records from each table to verify the data insertion.
SELECT * FROM ZipCodes;   -- View all zip codes and their corresponding cities.
SELECT * FROM Customers;  -- View all customer details.
SELECT * FROM Artists;    -- View all artist details.
SELECT * FROM Paintings;  -- View all painting details.
SELECT * FROM Sales;      -- View all sales transactions.


