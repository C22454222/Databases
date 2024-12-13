-- 1) Drop the tables if they already exist to avoid duplicates
drop table if exists Follow;
drop table if exists Likes;
drop table if exists Photos;
drop table if exists Users;

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
    UserID SERIAL,          -- Identification of the user who likes a photo(auto-incrementing integer)
    PhotoID INT NOT NULL,               -- Identification of the photo that got a like
    DateOfLike DATE NOT NULL            -- Date when the photo received a like
);

CREATE TABLE Follow (
    follower_id INT NOT NULL, -- Integer attribute of the follower
    followee_id INT NOT NULL, -- Integer attribute of the followee
    follow_date TIMESTAMP NOT NULL, -- Date and time of when they started following
    PRIMARY KEY (follower_id, followee_id), -- Compound primary key for follower and followee for the follow table
    FOREIGN KEY (follower_id) REFERENCES Users(UserID), -- Foreign keys to link the follow table to the users table 
    FOREIGN KEY (followee_id) REFERENCES Users(UserID)
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
   
insert into Follow (follower_id,followee_id, follow_date) VALUES
	(1,2,now()), -- Now() function captures the date and time when the sql query is run
	(2,3,now()), -- Other two values are normal integers
	(3,4,now());

-- Adding a foreign key constraint to link the Photos table to the Users table
ALTER TABLE Photos
ADD CONSTRAINT FK_Photos_Users
FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- Adds a foreign key constraint to link the Likes table to the Users table.
ALTER TABLE Likes
ADD CONSTRAINT FK_Likes_Users
FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- Adds a foreign key constraint to link the Likes table to the Photos table.
ALTER TABLE Likes
ADD CONSTRAINT FK_Likes_Photos
FOREIGN KEY (PhotoID)
REFERENCES Photos(PhotoID);

-- Created a compound primary key for the Likes table using UserID and PhotoID
ALTER TABLE Likes
ADD CONSTRAINT PK_Likes
PRIMARY KEY (UserID, PhotoID);

-- Adds a unique constraint to ensure usernames remain unique
ALTER TABLE Users
ADD CONSTRAINT UQ_Username
UNIQUE (Username);

-- Displays the tables. 
select * from Users;
select * from Photos;
select * from Likes;
select * from Follow;








