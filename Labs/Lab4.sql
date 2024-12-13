-- 1) Drop the tables if they already exist to avoid duplicates
drop table if exists Follow;
drop table if exists Likes;
drop table if exists Photos;
drop table if exists Users;

-- 2) Create the Users table.
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,          -- User identification (auto-incrementing integer)
    Username VARCHAR(255),     -- Username associated with the account
    CreatedAt DATE              -- Date when the profile was created
);

-- 3) Create the Photos table.
CREATE TABLE Photos (
    PhotoID SERIAL PRIMARY KEY,         -- Photo identification (auto-incrementing integer)
    ImageURL VARCHAR(255),     -- URL associated with the photo
    UserID INT,                -- Identification of the user who published the photo
    PublicationDate DATE        -- Date when the photo was published
);

-- 4) Create the Likes table.
CREATE TABLE Likes (
    UserID SERIAL,                      -- Identification of the user who likes a photo (auto-incrementing integer)
    PhotoID INT,               -- Identification of the photo that got a like
    DateOfLike DATE             -- Date when the photo received a like
);

CREATE TABLE Follow (
    follower_id INT,            -- Integer attribute of the follower
    followee_id INT,            -- Integer attribute of the followee
    follow_date DATE,           -- Date when they started following
    PRIMARY KEY (follower_id, followee_id), -- Compound primary key for follower and followee for the follow table
    FOREIGN KEY (follower_id) REFERENCES Users(UserID), -- Foreign keys to link the follow table to the Users table
    FOREIGN KEY (followee_id) REFERENCES Users(UserID)
);

-- Insertion into Users table. 5 rows.
INSERT INTO Users (Username, CreatedAt) VALUES
    ('john_schmuck', '2023-09-26'),
    ('jane_smithers', '2023-09-26'),
    ('jake_jackson', '2023-09-26'),
    ('susan_sass', '2023-09-26'),
    ('david_brownie', '2023-09-26');

--Insertion using mockaroo.
   
insert into Users (Username, CreatedAT) values ('Timothy', '2023-04-27');
insert into Users (Username, CreatedAT) values ('Gertrud', '2023-05-08');
insert into Users (Username, CreatedAT) values ('Afton', '2023-08-22');
insert into Users (Username, CreatedAT) values ('Terencio', '2023-07-15');
insert into Users (Username, CreatedAT) values ('Jere', '2023-02-20');
insert into Users (Username, CreatedAT) values ('Geri', '2023-06-15');
insert into Users (Username, CreatedAT) values ('Nerissa', '2023-08-27');
insert into Users (Username, CreatedAT) values ('Calvin', '2023-03-03');
insert into Users (Username, CreatedAT) values ('Ward', '2023-07-18');
insert into Users (Username, CreatedAT) values ('Theresa', '2023-01-17');

--Inserting an additional 10 rows with some NULL values

-- Inserting 10 additional rows into the Users table.
INSERT INTO Users (Username, CreatedAt) VALUES
    ('user1', '2023-10-01'),
    ('user2', '2023-10-02'),
    ('user3', '2023-10-03'),
    ('user4', '2023-10-04'),
    ('user5', '2023-10-05'),
    ('user6', '2023-10-06'),
    ('user7', '2023-10-07'),
    ('user8', '2023-10-08'),
    (NULL, '2023-10-09'), -- Inserting a NULL value for the Username
    ('user10', '2023-10-10');



-- Insertion into Photos table. 5 rows.
INSERT INTO Photos (ImageURL, UserID, PublicationDate) VALUES
    ('https://first1.com/photo1.jpg', 1, '2023-09-26'),
    ('https://second1.com/photo2.jpg', 2, '2023-09-26'),
    ('https://third1.com/photo3.jpg', 3, '2023-09-27'),
    ('https://fourth1.com/photo4.jpg', 4, '2023-09-27'),
    ('https://fifth1.com/photo5.jpg', 5, '2023-09-28');
   
-- Insertion using mockaroo.
insert into Photos (ImageURL, UserID, PublicationDate) values ('https://epa.gov/pellentesque/at/nulla.html', 6, '2023-05-12');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://java.com/tortor/eu/pede.html', 7, '2023-05-22');
insert into Photos (ImageURL, UserID, PublicationDate) values ('https://devhub.com/nunc/vestibulum.js', 8, '2022-11-04');
insert into Photos (ImageURL, UserID, PublicationDate) values ('https://plala.or.jp/cubilia/curae/nulla/dapibus/dolor/vel.aspx', 9, '2023-02-20');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://sciencedirect.com/odio/curabitur/convallis.png', 10, '2023-05-31');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://instagram.com/in/quis/justo.png', 11, '2023-04-18');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://smh.com.au/ac/nulla/sed/vel/enim/sit/amet.xml', 12, '2023-07-28');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://1688.com/diam/neque/vestibulum.json', 13, '2023-03-09');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://homestead.com/praesent/blandit/lacinia/erat.jsp', 14, '2023-05-06');
insert into Photos (ImageURL, UserID, PublicationDate) values ('http://umn.edu/in/tempor/turpis/nec/euismod.json', 15, '2023-06-19');


-- Insertion into Photos table. 10 rows

-- Inserting 10 additional rows into the Photos table
INSERT INTO Photos (ImageURL, UserID, PublicationDate) VALUES
    ('https://photo11.com/image1.jpg', 16, '2023-10-01'),
    ('https://photo12.com/image2.jpg',17, '2023-10-02'),
    ('https://photo13.com/image3.jpg', 18, '2023-10-03'),
    ('https://photo14.com/image4.jpg', 19, '2023-10-04'),
    ('https://photo15.com/image5.jpg', 20, '2023-10-05'),
    ('https://photo16.com/image6.jpg', 21, '2023-10-06'),
    ('https://photo17.com/image7.jpg', 22, '2023-10-07'),
    ('https://photo18.com/image8.jpg', NULL, '2023-10-08'), -- Inserting a null value for the userid.
    ('https://photo19.com/image9.jpg', 24, '2023-10-09'),
    ('https://photo20.com/image10.jpg', 25, '2023-10-10');


-- Insertion into Likes table. 5 rows.
INSERT INTO Likes (PhotoID, DateOfLike) VALUES
    (1, '2023-09-26'),
    (2, '2023-09-26'),
    (3, '2023-09-27'),
    (4, '2023-09-27'),
    (5, '2023-09-28');
   
-- Insertion using mockaroo.
insert into Likes (PhotoID, DateOfLike) values (6, '2023-06-12');
insert into Likes (PhotoID, DateOfLike) values (7, '2023-02-23');
insert into Likes (PhotoID, DateOfLike) values (8, '2023-05-17');
insert into Likes (PhotoID, DateOfLike) values (9, '2023-04-03');
insert into Likes (PhotoID, DateOfLike) values (10, '2023-01-09');
insert into Likes (PhotoID, DateOfLike) values (11, '2023-08-14');
insert into Likes (PhotoID, DateOfLike) values (12, '2023-08-24');
insert into Likes (PhotoID, DateOfLike) values (13, '2023-09-06');
insert into Likes (PhotoID, DateOfLike) values (14, '2022-12-01');
insert into Likes (PhotoID, DateOfLike) values (15, '2022-10-17');

-- Inserting 10 additional rows into the Likes table with UserIDs from 16 to 25
INSERT INTO Likes (PhotoID, DateOfLike) VALUES
    (16, '2023-10-11'), -- User 16 liking their own photo
    (17, '2023-10-12'), -- User 17 liking their own photo
    (18, '2023-10-13'), -- User 18 liking their own photo
    (19, '2023-10-14'), -- User 19 liking their own photo
    (20, '2023-10-15'), -- User 20 liking their own photo
    (21, '2023-10-16'), -- User 21 liking their own photo
    (22, '2023-10-17'), -- User 22 liking their own photo
    (23, '2023-10-18'), -- User 23 liking their own photo
    (24, '2023-10-19'), -- User 24 liking their own photo
    (25, '2023-10-20'); -- User 25 liking their own photo


INSERT INTO Follow (follower_id, followee_id, follow_date) VALUES
    (1, 2, '2023-09-26'), -- Now() function captures the date and time when the SQL query is run
    (2, 3, '2023-09-26'), -- Other two values are normal integers
    (3, 4, '2023-09-26');
   
-- Insertion using mockaroo.
insert into Follow (follower_id, followee_id, follow_date) values (6, 6, '2023-04-04');
insert into Follow (follower_id, followee_id, follow_date) values (7, 7, '2022-11-14');
insert into Follow (follower_id, followee_id, follow_date) values (8, 8, '2023-05-25');
insert into Follow (follower_id, followee_id, follow_date) values (9, 9, '2023-03-15');
insert into Follow (follower_id, followee_id, follow_date) values (10, 10, '2023-05-04');
insert into Follow (follower_id, followee_id, follow_date) values (11, 11, '2022-10-19');
insert into Follow (follower_id, followee_id, follow_date) values (12, 12, '2023-09-26');
insert into Follow (follower_id, followee_id, follow_date) values (13, 13, '2023-07-19');
insert into Follow (follower_id, followee_id, follow_date) values (14, 14, '2023-04-16');
insert into Follow (follower_id, followee_id, follow_date) values (15, 15, '2023-04-09');

-- Inserting 10 additional rows into the Follow table with follower and followee IDs from 16 to 25
INSERT INTO Follow (follower_id, followee_id, follow_date) VALUES
    (16, 17, '2023-10-11'), -- User 16 follows User 17
    (17, 18, '2023-10-12'), -- User 17 follows User 18
    (18, 19, '2023-10-13'), -- User 18 follows User 19
    (19, 20, '2023-10-14'), -- User 19 follows User 20
    (20, 21, '2023-10-15'), -- User 20 follows User 21
    (21, 22, '2023-10-16'), -- User 21 follows User 22
    (22, 23, '2023-10-17'), -- User 22 follows User 23
    (23, 24, '2023-10-18'), -- User 23 follows User 24
    (24, 25, '2023-10-19'), -- User 24 follows User 25
    (25, 25, '2023-10-20'); -- User 25 follows user 25



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
SELECT * FROM Users;
SELECT * FROM Photos;
SELECT * FROM Likes;
SELECT * FROM Follow;

-- Retrieved the usernames of users who liked a specific photo with PhotoID 3.

-- Selected the Username column from the Users table.
SELECT Users.Username

FROM Likes -- Joined the Likes and Users tables based on the UserID column.

JOIN Users ON Likes.UserID = Users.UserID -- Joined the Likes table to the Users table using the UserID column as the link.

WHERE Likes.PhotoID = 3;


-- Retrieve the usernames of users who followed a specific user (follower) with FollowerID 3.

SELECT Users.Username

FROM Follow

JOIN Users ON Follow.follower_id = Users.UserID

WHERE Follow.follower_id = 3;

-- Retrieve the usernames of users who liked a specific photo (e.g., PhotoID 3) before a specific date (e.g., '2023-09-01').


SELECT Users.Username

FROM Likes

JOIN Users ON Likes.UserID = Users.UserID

WHERE Likes.PhotoID = 3

-- Specify a condition to filter the results to likes before a specific date ('jake_jackson', '2023-09-26')
AND Likes.DateOfLike < '2023-10-10';










