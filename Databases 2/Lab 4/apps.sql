DROP TABLE IF EXISTS Apps_NOT_Normalized cascade;
Create Table Apps_NOT_Normalized(
  App_No integer,
  StudentID integer,
  StudentName varchar(50),
  Street varchar(100),
  State varchar(30),
  ZipCode varchar(7),
  App_Year integer,
  ReferenceName varchar(100),
  RefInstitution  varchar(100),
  ReferenceStatement varchar(500),
  PriorSchoolId integer,
  PriorSchoolAddr varchar(100),
  GPA numeric(2)
);

insert into Apps_NOT_Normalized values(1,1,'Mark','Grafton Street','New York','NY234',2003,'Dr. Jones','Trinity College','Good guy',1,'Castleknock',65);
insert into Apps_NOT_Normalized values(1,1,'Mark','Grafton Street','New York','NY234',2004,'Dr. Jones','Trinity College','Good guy',1,'Castleknock',65);
insert into Apps_NOT_Normalized values(2,1,'Mark','White Street','Florida','Flo435',2007,'Dr. Jones','Trinity College','Good guy',1,'Castleknock',65);
insert into Apps_NOT_Normalized values(2,1,'Mark','White Street','Florida','Flo435',2007,'Dr. Jones','Trinity College','Good guy',2,'Loreto College',87);
insert into Apps_NOT_Normalized values(3,1,'Mark','White Street','Florida','Flo435',2012,'Dr. Jones','U Limerick','Very Good guy',1,'Castleknock',65);
insert into Apps_NOT_Normalized values(3,1,'Mark','White Street','Florida','Flo435',2012,'Dr. Jones','U Limerick','Very Good guy',2,'Loreto College',87);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2010,'Dr. Byrne','DIT','Perfect',1,'Castleknock',90);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2010,'Dr. Byrne','DIT','Perfect',3,'St. Patrick',76);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2011,'Dr. Byrne','DIT','Perfect',1,'Castleknock',90);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2011,'Dr. Byrne','DIT','Perfect',3,'St. Patrick',76);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2012,'Dr. Byrne','UCD','Average',1,'Castleknock',90);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2012,'Dr. Byrne','UCD','Average',3,'St. Patrick',76);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2012,'Dr. Byrne','UCD','Average',4,'DBS',66);
insert into Apps_NOT_Normalized values(2,2,'Sarah','Green Road','California','Cal123',2012,'Dr. Byrne','UCD','Average',5,'Harvard',45);
insert into Apps_NOT_Normalized values(1,3,'Paul','Red Crescent','Carolina','Ca455',2012,'Dr. Jones','Trinity College','Poor',1,'Castleknock',45);
insert into Apps_NOT_Normalized values(1,3,'Paul','Red Crescent','Carolina','Ca455',2012,'Dr. Jones','Trinity College','Poor',3,'St. Patrick',67);
insert into Apps_NOT_Normalized values(1,3,'Paul','Red Crescent','Carolina','Ca455',2012,'Dr. Jones','Trinity College','Poor',4,'DBS',23);
insert into Apps_NOT_Normalized values(1,3,'Paul','Red Crescent','Carolina','Ca455',2012,'Dr. Jones','Trinity College','Poor',5,'Harvard',67);
insert into Apps_NOT_Normalized values(3,3,'Paul','Yellow Park','Mexico','Mex1',2008,'Prof. Cahill','UCC','Excellent',1,'Castleknock',45);
insert into Apps_NOT_Normalized values(3,3,'Paul','Yellow Park','Mexico','Mex1',2008,'Prof. Cahill','UCC','Excellent',3,'St. Patrick',67);
insert into Apps_NOT_Normalized values(3,3,'Paul','Yellow Park','Mexico','Mex1',2008,'Prof. Cahill','UCC','Excellent',4,'DBS',23);
insert into Apps_NOT_Normalized values(3,3,'Paul','Yellow Park','Mexico','Mex1',2008,'Prof. Cahill','UCC','Excellent',5,'Harvard',67);
insert into Apps_NOT_Normalized values(1,4,'Jack','Dartry Road','Ohio','Oh34',2009,'Prof. Lillis','DIT','Fair',3,'St. Patrick',29);
insert into Apps_NOT_Normalized values(1,4,'Jack','Dartry Road','Ohio','Oh34',2009,'Prof. Lillis','DIT','Fair',4,'DBS',88);
insert into Apps_NOT_Normalized values(1,4,'Jack','Dartry Road','Ohio','Oh34',2009,'Prof. Lillis','DIT','Fair',5,'Harvard',66);
insert into Apps_NOT_Normalized values(2,5,'Mary','Malahide Road','Ireland','IRE',2009,'Prof. Lillis','DIT','Good girl',3,'St. Patrick',44);
insert into Apps_NOT_Normalized values(2,5,'Mary','Malahide Road','Ireland','IRE',2009,'Prof. Lillis','DIT','Good girl',4,'DBS',55);
insert into Apps_NOT_Normalized values(2,5,'Mary','Malahide Road','Ireland','IRE',2009,'Prof. Lillis','DIT','Good girl',5,'Harvard',66);
insert into Apps_NOT_Normalized values(2,5,'Mary','Malahide Road','Ireland','IRE',2009,'Prof. Lillis','DIT','Good girl',1,'Castleknock',74);
insert into Apps_NOT_Normalized values(1,5,'Mary','Black Bay','Kansas','Kan45',2005,'Dr. Byrne','DIT','Perfect',3,'St. Patrick',44);
insert into Apps_NOT_Normalized values(1,5,'Mary','Black Bay','Kansas','Kan45',2005,'Dr. Byrne','DIT','Perfect',4,'DBS',55);
insert into Apps_NOT_Normalized values(1,5,'Mary','Black Bay','Kansas','Kan45',2005,'Dr. Byrne','DIT','Perfect',5,'Harvard',66);
insert into Apps_NOT_Normalized values(3,6,'Susan','River Road','Kansas','Kan45',2011,'Prof. Cahill','UCC','Messy',1,'Castleknock',88);
insert into Apps_NOT_Normalized values(3,6,'Susan','River Road','Kansas','Kan45',2011,'Prof. Cahill','UCC','Messy',3,'St. Patrick',77);
insert into Apps_NOT_Normalized values(3,6,'Susan','River Road','Kansas','Kan45',2011,'Prof. Cahill','UCC','Messy',4,'DBS',56);
insert into Apps_NOT_Normalized values(3,6,'Susan','River Road','Kansas','Kan45',2011,'Prof. Cahill','UCC','Messy',2,'Loreto College',45);

select * from Apps_NOT_Normalized;

-- Drop existing tables if they exist
-- This ensures that we start with a clean slate to avoid conflicts with pre-existing data.

DROP TABLE IF EXISTS StudentPriorSchools cascade;
DROP TABLE IF EXISTS ReferenceLetters cascade;
DROP TABLE IF EXISTS Applications cascade;
DROP TABLE IF EXISTS StudentAddresses cascade;
DROP TABLE IF EXISTS Students cascade;
DROP TABLE IF EXISTS Referees cascade;
DROP TABLE IF EXISTS PriorSchools cascade;

-- Students table (1NF, 2NF, 3NF)
-- The Students table contains StudentID as the primary key and StudentName. 
-- This satisfies 1NF by ensuring each field contains atomic values (no repeating groups). 
-- It satisfies 2NF because all non-key attributes (StudentName) are fully functionally dependent on the primary key (StudentID). 
-- It satisfies 3NF because there are no transitive dependencies (i.e., StudentName depends only on StudentID, and not indirectly through other attributes).
CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY,
    StudentName VARCHAR(50)
);

-- StudentAddresses table (1NF, 2NF, 3NF)
-- The StudentAddresses table uses a composite primary key of StudentID and AddressID.
-- This table ensures 1NF by containing atomic values (one value per column).
-- It satisfies 2NF because AddressID is fully dependent on the primary key (StudentID, AddressID), and no non-prime attributes depend on a part of the primary key.
-- The table satisfies 3NF because all non-key attributes (Street, State, ZipCode) depend only on AddressID and not indirectly on StudentID.
CREATE TABLE StudentAddresses (
    AddressID SERIAL PRIMARY KEY,
    StudentID INTEGER,
    Street VARCHAR(100),
    State VARCHAR(30),
    ZipCode VARCHAR(7),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Applications table (1NF, 2NF, 3NF)
-- The Applications table has AppID as a primary key and a composite foreign key (StudentID, AddressID).
-- This table is in 1NF, as it avoids repeating groups of data. 
-- The table satisfies 2NF because App_No and App_Year together form a composite key that uniquely identifies each application, and App_No and App_Year depend on the primary key (AppID). 
-- It satisfies 3NF because there are no transitive dependencies.
CREATE TABLE Applications (
    AppID SERIAL PRIMARY KEY,
    App_No INTEGER,
    StudentID INTEGER,
    AddressID INTEGER,
    App_Year INTEGER,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (AddressID) REFERENCES StudentAddresses(AddressID),
    UNIQUE (App_No, App_Year) -- Ensures uniqueness of applications
);

-- Referees table (1NF, 2NF, 3NF)
-- The Referees table contains unique combinations of ReferenceName and RefInstitution, making it in 1NF as no repeating groups exist.
-- This table also satisfies 2NF since ReferenceName and RefInstitution together form the composite primary key, and there is no partial dependency.
-- It satisfies 3NF because the attributes (ReferenceName, RefInstitution) do not depend on anything other than the composite primary key.
CREATE TABLE Referees (
    RefereeID SERIAL PRIMARY KEY,
    ReferenceName VARCHAR(100),
    RefInstitution VARCHAR(100),
    UNIQUE (ReferenceName, RefInstitution)
);

-- ReferenceLetters table (1NF, 2NF, 3NF)
-- This table stores reference letters associated with applications. It uses AppID and RefereeID as foreign keys.
-- It is in 1NF since all attributes contain atomic values. 
-- The table satisfies 2NF because the non-key attribute (ReferenceStatement) is fully dependent on the primary key (AppID, RefereeID). 
-- It also satisfies 3NF, as there are no transitive dependencies.
CREATE TABLE ReferenceLetters (
    ReferenceID SERIAL PRIMARY KEY,
    AppID INTEGER,
    RefereeID INTEGER,
    ReferenceStatement VARCHAR(500),
    FOREIGN KEY (AppID) REFERENCES Applications(AppID),
    FOREIGN KEY (RefereeID) REFERENCES Referees(RefereeID)
);

-- PriorSchools table (1NF, 2NF, 3NF)
-- The PriorSchools table is designed to store information about schools prior to the current application.
-- It satisfies 1NF because all attributes are atomic.
-- It satisfies 2NF because PriorSchoolId is the primary key, and PriorSchoolAddr fully depends on it.
-- It is in 3NF because there are no transitive dependencies.
CREATE TABLE PriorSchools (
    PriorSchoolId INTEGER PRIMARY KEY,
    PriorSchoolAddr VARCHAR(100)
);

-- StudentPriorSchools table (1NF, 2NF, 3NF)
-- This table links students to their prior schools, including the GPA. It uses a composite primary key (StudentID, PriorSchoolId).
-- The table satisfies 1NF by ensuring atomic attributes.
-- It satisfies 2NF as GPA depends on both StudentID and PriorSchoolId, meaning no partial dependencies exist.
-- It also satisfies 3NF because there are no transitive dependencies; GPA depends directly on both keys.
CREATE TABLE StudentPriorSchools (
    StudentID INTEGER,
    PriorSchoolId INTEGER,
    GPA NUMERIC(2),
    PRIMARY KEY (StudentID, PriorSchoolId),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (PriorSchoolId) REFERENCES PriorSchools(PriorSchoolId)
);

-- Insert data into Students table
-- This inserts unique students into the Students table by selecting distinct values from the original unnormalized dataset.

INSERT INTO Students (StudentID, StudentName)
SELECT DISTINCT StudentID, StudentName
FROM Apps_NOT_Normalized;

-- Insert data into StudentAddresses table
-- This step ensures that student addresses are stored only once in the StudentAddresses table, linked by the StudentID.

INSERT INTO StudentAddresses (StudentID, Street, State, ZipCode)
SELECT DISTINCT StudentID, Street, State, ZipCode
FROM Apps_NOT_Normalized;

-- Insert data into Applications table
-- This populates the Applications table, linking each application to a unique student and address by referencing the StudentID and AddressID.

INSERT INTO Applications (App_No, StudentID, AddressID, App_Year)
SELECT DISTINCT a.App_No, a.StudentID, sa.AddressID, a.App_Year
FROM Apps_NOT_Normalized a
JOIN StudentAddresses sa ON a.StudentID = sa.StudentID AND a.Street = sa.Street AND a.State = sa.State AND a.ZipCode = sa.ZipCode;

-- Insert data into Referees table
-- The Referees table is populated by selecting unique references from the original dataset, ensuring that the data is normalized by removing duplicates.

INSERT INTO Referees (ReferenceName, RefInstitution)
SELECT DISTINCT ReferenceName, RefInstitution
FROM Apps_NOT_Normalized;

-- Insert data into ReferenceLetters table
-- This step populates the ReferenceLetters table by associating applications with their corresponding referees and reference statements.

INSERT INTO ReferenceLetters (AppID, RefereeID, ReferenceStatement)
SELECT DISTINCT a.AppID, r.RefereeID, an.ReferenceStatement
FROM Apps_NOT_Normalized an
JOIN Applications a ON an.App_No = a.App_No AND an.StudentID = a.StudentID AND an.App_Year = a.App_Year
JOIN Referees r ON an.ReferenceName = r.ReferenceName AND an.RefInstitution = r.RefInstitution;

-- Insert data into PriorSchools table
-- Insert unique prior schools data into the PriorSchools table.

INSERT INTO PriorSchools (PriorSchoolId, PriorSchoolAddr)
SELECT DISTINCT PriorSchoolId, PriorSchoolAddr
FROM Apps_NOT_Normalized;

-- Insert data into StudentPriorSchools table
-- Insert data linking students with prior schools and their GPAs into the StudentPriorSchools table.

INSERT INTO StudentPriorSchools (StudentID, PriorSchoolId, GPA)
SELECT DISTINCT StudentID, PriorSchoolId, GPA
FROM Apps_NOT_Normalized;

-- Select all data from Students table
-- This retrieves all records from the Students table for verification.

SELECT * FROM Students;

-- Select all data from StudentAddresses table
-- This retrieves all records from the StudentAddresses table for verification.

SELECT * FROM StudentAddresses;

-- Select all data from Applications table
-- This retrieves all records from the Applications table for verification.

SELECT * FROM Applications;

-- Select all data from Referees table
-- This retrieves all records from the Referees table for verification.

SELECT * FROM Referees;

-- Select all data from References table
-- This retrieves all records from the ReferenceLetters table for verification.

SELECT * FROM ReferenceLetters;

-- Select all data from PriorSchools table
-- This retrieves all records from the PriorSchools table for verification.

SELECT * FROM PriorSchools;

-- Select all data from StudentPriorSchools table
-- This retrieves all records from the StudentPriorSchools table for verification.

SELECT * FROM StudentPriorSchools;

