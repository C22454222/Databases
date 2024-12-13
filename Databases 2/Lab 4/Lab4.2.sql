DROP TABLE IF EXISTS ApplicationPriorSchools CASCADE;
DROP TABLE IF EXISTS ReferenceLetters CASCADE;
DROP TABLE IF EXISTS Applications CASCADE;
DROP TABLE IF EXISTS Addresses CASCADE;
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Referees CASCADE;
DROP TABLE IF EXISTS PriorSchools CASCADE;
DROP TABLE IF EXISTS StudentPriorSchools CASCADE;

-- Create normalized tables
CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Addresses (
    AddressID INTEGER PRIMARY KEY,
    StudentID INTEGER,
    Street VARCHAR(100),
    State VARCHAR(30),
    ZipCode VARCHAR(7),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

CREATE TABLE Applications (
    App_No INTEGER,
    App_Year INTEGER,
    StudentID INTEGER,
    AddressID INTEGER,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
    UNIQUE (StudentID, App_Year)
);

CREATE TABLE Referees (
    RefereeID INTEGER PRIMARY KEY,
    ReferenceName VARCHAR(100),
    RefInstitution VARCHAR(100),
    UNIQUE (ReferenceName, RefInstitution)
);

CREATE TABLE ReferenceLetters (
    ReferenceID INTEGER PRIMARY KEY,
    App_No INTEGER,
    RefereeID INTEGER,
    ReferenceStatement VARCHAR(500),
    FOREIGN KEY (App_No) REFERENCES Applications(App_No),
    FOREIGN KEY (RefereeID) REFERENCES Referees(RefereeID)
);

CREATE TABLE PriorSchools (
    PriorSchoolId INTEGER PRIMARY KEY,
    PriorSchoolAddr VARCHAR(100)
);

CREATE TABLE StudentPriorSchools (
    StudentID INTEGER,
    PriorSchoolId INTEGER,
    GPA NUMERIC(3,1),
    PRIMARY KEY (StudentID, PriorSchoolId),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (PriorSchoolId) REFERENCES PriorSchools(PriorSchoolId)
);

CREATE TABLE ApplicationPriorSchools (
    App_No INTEGER,
    PriorSchoolId INTEGER,
    PRIMARY KEY (App_No, PriorSchoolId),
    FOREIGN KEY (App_No) REFERENCES Applications(App_No),
    FOREIGN KEY (PriorSchoolId) REFERENCES PriorSchools(PriorSchoolId)
);

-- Clear existing data from all tables
DELETE FROM ApplicationPriorSchools;
DELETE FROM StudentPriorSchools;
DELETE FROM PriorSchools;
DELETE FROM ReferenceLetters;
DELETE FROM Referees;
DELETE FROM Applications;
DELETE FROM Addresses;
DELETE FROM Students;

-- Insert data into Students
INSERT INTO Students (StudentID, StudentName) VALUES
(1, 'Mark'),
(2, 'Sarah'),
(3, 'Paul'),
(4, 'Jack'),
(5, 'Mary'),
(6, 'Susan');

-- Insert data into Addresses
INSERT INTO Addresses (AddressID, StudentID, Street, State, ZipCode) VALUES
(1, 1, 'Grafton Street', 'New York', 'NY234'),
(2, 1, 'White Street', 'Florida', 'Flo435'),
(3, 2, 'Green Road', 'California', 'Cal123'),
(4, 3, 'Red Crescent', 'Carolina', 'Ca455'),
(5, 3, 'Yellow Park', 'Mexico', 'Mex1'),
(6, 4, 'Dartry Road', 'Ohio', 'Oh34'),
(7, 5, 'Malahide Road', 'Ireland', 'IRE'),
(8, 5, 'Black Bay', 'Kansas', 'Kan45'),
(9, 6, 'River Road', 'Kansas', 'Kan45');

-- Insert data into Applications (32 applications)
INSERT INTO Applications (App_No, StudentID, App_Year, AddressID) VALUES
(1, 1, 2003, 1),
(2, 1, 2004, 1),
(3, 1, 2007, 2),
(4, 1, 2007, 2),
(5, 1, 2012, 2),
(6, 1, 2012, 2),
(7, 2, 2010, 3),
(8, 2, 2010, 3),
(9, 2, 2011, 3),
(10, 2, 2011, 3),
(11, 2, 2012, 3),
(12, 2, 2012, 3),
(13, 2, 2012, 3),
(14, 2, 2012, 3),
(15, 3, 2012, 4),
(16, 3, 2012, 4),
(17, 3, 2012, 4),
(18, 3, 2012, 4),
(19, 3, 2008, 5),
(20, 3, 2008, 5),
(21, 3, 2008, 5),
(22, 3, 2008, 5),
(23, 4, 2009, 6),
(24, 4, 2009, 6),
(25, 4, 2009, 6),
(26, 5, 2009, 7),
(27, 5, 2009, 7),
(28, 5, 2009, 7),
(29, 5, 2009, 7),
(30, 5, 2005, 8),
(31, 5, 2005, 8),
(32, 5, 2005, 8);

-- Insert data into Referees
INSERT INTO Referees (RefereeID, ReferenceName, RefInstitution) VALUES
(1, 'Dr. Jones', 'Trinity College'),
(2, 'Dr. Jones', 'U Limerick'),
(3, 'Dr. Byrne', 'DIT'),
(4, 'Dr. Byrne', 'UCD'),
(5, 'Prof. Cahill', 'UCC'),
(6, 'Prof. Lillis', 'DIT');

-- Insert data into ReferenceLetters
INSERT INTO ReferenceLetters (ReferenceID, App_No, RefereeID, ReferenceStatement) VALUES
(1, 1, 1, 'Good guy'),
(2, 2, 1, 'Good guy'),
(3, 3, 1, 'Good guy'),
(4, 5, 2, 'Very Good guy'),
(5, 7, 3, 'Perfect'),
(6, 9, 3, 'Perfect'),
(7, 11, 4, 'Average'),
(8, 15, 1, 'Poor'),
(9, 19, 5, 'Excellent'),
(10, 23, 6, 'Fair'),
(11, 26, 6, 'Good girl'),
(12, 30, 3, 'Perfect'),
(13, 32, 5, 'Messy');

-- Insert data into PriorSchools
INSERT INTO PriorSchools (PriorSchoolId, PriorSchoolAddr) VALUES
(1, 'Castleknock'),
(2, 'Loreto College'),
(3, 'St. Patrick'),
(4, 'DBS'),
(5, 'Harvard');

-- Insert data into StudentPriorSchools
INSERT INTO StudentPriorSchools (StudentID, PriorSchoolId, GPA) VALUES
(1, 1, 65),
(1, 2, 87),
(2, 1, 90),
(2, 3, 76),
(2, 4, 66),
(2, 5, 45),
(3, 1, 45),
(3, 3, 67),
(3, 4, 23),
(3, 5, 67),
(4, 3, 29),
(4, 4, 88),
(4, 5, 66),
(5, 1, 74),
(5, 3, 44),
(5, 4, 55),
(5, 5, 66),
(6, 1, 88),
(6, 2, 45),
(6, 3, 77),
(6, 4, 56);

-- Insert data into ApplicationPriorSchools
INSERT INTO ApplicationPriorSchools (App_No, PriorSchoolId)
SELECT a.App_No, ps.PriorSchoolId
FROM Applications a
CROSS JOIN PriorSchools ps
WHERE (a.StudentID = 1 AND ps.PriorSchoolId IN (1, 2))
   OR (a.StudentID = 2 AND ps.PriorSchoolId IN (1, 3, 4, 5))
   OR (a.StudentID = 3 AND ps.PriorSchoolId IN (1, 3, 4, 5))
   OR (a.StudentID = 4 AND ps.PriorSchoolId IN (3, 4, 5))
   OR (a.StudentID = 5 AND ps.PriorSchoolId IN (1, 3, 4, 5))
   OR (a.StudentID = 6 AND ps.PriorSchoolId IN (1, 2, 3, 4));