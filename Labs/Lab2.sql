-- 1) Drop the tables if they already exist to avoid duplicates.
DROP TABLE IF EXISTS Likes;
DROP TABLE IF EXISTS Photos;
DROP TABLE IF EXISTS Users;

-- 2) Create the Users table.
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,          -- User identification (auto-incrementing integer)
    Username VARCHAR(255) NOT NULL,     -- Username associated with the account
    CreatedAt TIMESTAMP NOT NULL        -- Date when the profile was created
);

-- 3) Create the Photos table.
CREATE TABLE Photos (
    PhotoID SERIAL PRIMARY KEY,         -- Photo identification (auto-incrementing integer)
    ImageURL VARCHAR(255) NOT NULL,     -- URL associated with the photo
    UserID INT NOT NULL,                -- Identification of the user who published the photo
    PublicationDate DATE NOT NULL       -- Date when the photo was published
);

-- 4) Create the Likes table.
CREATE TABLE Likes (
    UserID SERIAL PRIMARY KEY,          -- Identification of the user who likes a photo(auto-incrementing integer)
    PhotoID INT NOT NULL,               -- Identification of the photo that got a like
    DateOfLike DATE NOT NULL            -- Date when the photo received a like
);

-- Insertion into Users table. 5 rows.
INSERT INTO Users (Username, CreatedAt) VALUES
    ('john_schmuck', '2023-09-26 08:30:00'),
    ('jane_smithers', '2023-09-26 09:15:00'),
    ('jake_jackson', '2023-09-26 10:00:00'),
    ('susan_sass', '2023-09-26 10:45:00'),
    ('david_brownie', '2023-09-26 11:30:00');

-- Insertion into Photos table. 5 rows.
INSERT INTO Photos (ImageURL, UserID, PublicationDate) VALUES
    ('https://first1.com/photo1.jpg',1, '2023-09-26'),
    ('https://second1.com/photo2.jpg',2, '2023-09-26'),
    ('https://third1.com/photo3.jpg',3, '2023-09-27'),
    ('https://fourth1.com/photo4.jpg',4, '2023-09-27'),
    ('https://fifth1.com/photo5.jpg',5, '2023-09-28');
   
-- Insertion into Likes table. 5 rows.
INSERT INTO Likes ( PhotoID, DateOfLike) VALUES
    (1, '2023-09-26'),
    (1, '2023-09-26'),
    (2, '2023-09-27'),
    (2, '2023-09-27'),
    (3, '2023-09-28');

-- Displays the tables.
SELECT * FROM Users;
SELECT * FROM Photos;
SELECT * FROM Likes;

















