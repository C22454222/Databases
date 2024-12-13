-- Drop BookedSeats table
DROP TABLE IF EXISTS BookedSeats CASCADE;

-- Drop Seats table
DROP TABLE IF EXISTS Seats CASCADE;

-- Drop BookingDetails table
DROP TABLE IF EXISTS BookingDetails CASCADE;

-- Drop Bookings table
DROP TABLE IF EXISTS Bookings CASCADE;

-- Drop TicketTypes table
DROP TABLE IF EXISTS TicketTypes CASCADE;

-- Drop Customers table
DROP TABLE IF EXISTS Customer CASCADE;

-- Drop Shows table
DROP TABLE IF EXISTS Shows CASCADE;

-- Drop Screens table
DROP TABLE IF EXISTS Screens CASCADE;

-- Drop Movies table
DROP TABLE IF EXISTS Movies CASCADE;

-- Drop Cinemas table
DROP TABLE IF EXISTS Cinemas CASCADE;
-- Cinemas table
CREATE TABLE Cinemas (
    CinemaID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    NumberOfScreens INT NOT NULL
);

-- Screens table
CREATE TABLE Screens (
    ScreenID SERIAL PRIMARY KEY,
    CinemaID INT,
    ScreenNumber INT NOT NULL,
    NumberOfSeats INT NOT NULL,
    FOREIGN KEY (CinemaID) REFERENCES Cinemas(CinemaID)
);

-- Movies table
CREATE TABLE Movies (
    MovieID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Duration INT NOT NULL,
    Rating VARCHAR(10) NOT NULL
);

-- Shows table
CREATE TABLE Shows (
    ShowID SERIAL PRIMARY KEY,
    MovieID INT,
    ScreenID INT,
    ShowDateTime TIMESTAMP NOT NULL,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID)
);

-- Customers table
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL
);

-- TicketTypes table
CREATE TABLE TicketTypes (
    TicketTypeID SERIAL PRIMARY KEY,
    TypeName VARCHAR(20) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- Bookings table
CREATE TABLE Bookings (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INT,
    ShowID INT,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    BookingDateTime TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

-- BookingDetails table
CREATE TABLE BookingDetails (
    BookingDetailID SERIAL PRIMARY KEY,
    BookingID INT,
    TicketTypeID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (TicketTypeID) REFERENCES TicketTypes(TicketTypeID)
);

-- Seats table
CREATE TABLE Seats (
    SeatID SERIAL PRIMARY KEY,
    ScreenID INT,
    SeatNumber VARCHAR(10) NOT NULL,
    FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID)
);

-- BookedSeats table
CREATE TABLE BookedSeats (
    BookedSeatID SERIAL PRIMARY KEY,
    BookingID INT,
    SeatID INT,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID)
);

-- Insert data into Cinemas table
INSERT INTO Cinemas (Name, Location, ContactNumber, NumberOfScreens)
VALUES 
('Cinema 1', 'New York', '123-456-7890', 5),
('Cinema 2', 'Los Angeles', '987-654-3210', 4),
('Cinema 3', 'Chicago', '555-123-4567', 3);

-- Insert data into Screens table
INSERT INTO Screens (CinemaID, ScreenNumber, NumberOfSeats)
VALUES 
(1, 1, 200),
(1, 2, 250),
(1, 3, 300),
(1, 4, 200),
(1, 5, 250),
(2, 1, 250),
(2, 2, 300),
(2, 3, 200),
(2, 4, 250),
(3, 1, 200),
(3, 2, 250),
(3, 3, 300);

-- Insert data into Movies table
INSERT INTO Movies (Title, Duration, Rating)
VALUES 
('Movie 1', 120, 'PG-13'),
('Movie 2', 150, 'R'),
('Movie 3', 90, 'PG');

-- Insert data into Shows table
INSERT INTO Shows (MovieID, ScreenID, ShowDateTime)
VALUES 
(1, 1, '2024-07-26 10:00:00'),
(1, 2, '2024-07-26 13:00:00'),
(1, 3, '2024-07-26 16:00:00'),
(2, 4, '2024-07-26 19:00:00'),
(2, 5, '2024-07-26 22:00:00'),
(3, 6, '2024-07-26 10:00:00'),
(3, 7, '2024-07-26 13:00:00'),
(3, 8, '2024-07-26 16:00:00');

-- Insert data into Customers table
INSERT INTO Customer (Username, Password, DateOfBirth)
VALUES 
('user1', 'password1', '1990-01-01'),
('user2', 'password2', '1995-01-01'),
('user3', 'password3', '2000-01-01');

-- Insert data into TicketTypes table
INSERT INTO TicketTypes (TypeName, Price)
VALUES 
('Adult', 15.00),
('Child', 10.00),
('Senior', 12.00);

-- Insert data into Bookings table
INSERT INTO Bookings (CustomerID, ShowID, TotalPrice, BookingDateTime)
VALUES 
(1, 1, 30.00, '2024-07-25 10:00:00'),
(1, 2, 30.00, '2024-07-25 13:00:00'),
(2, 3, 20.00, '2024-07-25 16:00:00'),
(3, 4, 45.00, '2024-07-25 19:00:00');

-- Insert data into BookingDetails table
INSERT INTO BookingDetails (BookingID, TicketTypeID, Quantity)
VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 3, 1),
(4, 1, 3);

-- Insert data into Seats table
INSERT INTO Seats (ScreenID, SeatNumber)
VALUES 
(1, 'A1'),
(1, 'A2'),
(1, 'B1'),
(1, 'B2'),
(2, 'A1'),
(2, 'A2'),
(2, 'B1'),
(2, 'B2'),
(3, 'A1'),
(3, 'A2'),
(3, 'B1'),
(3, 'B2');

-- Insert data into BookedSeats table
INSERT INTO BookedSeats (BookingID, SeatID)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(4, 6),
(4, 7);

-- Select all records from Cinemas table
SELECT * FROM Cinemas;

-- Select all records from Screens table
SELECT * FROM Screens;

-- Select all records from Movies table
SELECT * FROM Movies;

-- Select all records from Shows table
SELECT * FROM Shows;

-- Select all records from Customers table
SELECT * FROM Customer;

-- Select all records from TicketTypes table
SELECT * FROM TicketTypes;

-- Select all records from Bookings table
SELECT * FROM Bookings;

-- Select all records from BookingDetails table
SELECT * FROM BookingDetails;

-- Select all records from Seats table
SELECT * FROM Seats;

-- Select all records from BookedSeats table
SELECT * FROM BookedSeats;
