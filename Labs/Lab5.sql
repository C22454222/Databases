-- 1) Drop the tables if they already exist to avoid duplicates
DROP TABLE IF EXISTS Follow;
DROP TABLE IF EXISTS Likes;
DROP TABLE IF EXISTS Photos;
DROP TABLE IF EXISTS Users;

-- 2) Create the Users table.
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,    -- User identification (auto-incrementing integer)
    Username VARCHAR(255),        -- Username associated with the account
    CreatedAt DATE                -- Date when the profile was created
);

-- 3) Create the Photos table.
CREATE TABLE Photos (
    PhotoID SERIAL PRIMARY KEY,    -- Photo identification (auto-incrementing integer)
    ImageURL VARCHAR(255),        -- URL associated with the photo
    UserID INT,                   -- Identification of the user who published the photo
    PublicationDate DATE          -- Date when the photo was published
);

-- 4) Create the Likes table.
CREATE TABLE Likes (
    UserID SERIAL,                -- Identification of the user who likes a photo (auto-incrementing integer)
    PhotoID INT,                 -- Identification of the photo that got a like
    DateOfLike DATE              -- Date when the photo received a like
);

CREATE TABLE Follow (
    follower_id INT,             -- Integer attribute of the follower
    followee_id INT,             -- Integer attribute of the followee
    follow_date DATE,            -- Date when they started following
    PRIMARY KEY (follower_id, followee_id), -- Compound primary key for follower and followee for the follow table
    FOREIGN KEY (follower_id) REFERENCES Users(UserID), -- Foreign keys to link the follow table to the Users table
    FOREIGN KEY (followee_id) REFERENCES Users(UserID)
);

-- Insertion into Users table. 25 rows.
INSERT INTO Users (Username, CreatedAt)
VALUES
    ('user1', '2023-09-26'),
    ('user2', '2023-09-26'),
    ('user3', '2023-09-26'),
    ('user4', '2023-09-26'),
    ('user5', '2023-09-26'),
    ('user6', '2023-09-26'),
    ('user7', '2023-09-26'),
    ('user8', '2023-09-26'),
    ('user9(more than ten characters)', '2023-09-26'),
    ('user10', '2023-09-26'),
    ('user11', '2023-09-26'),
    ('user12', '2023-09-26'),
    ('user13', '2023-09-26'),
    ('user14', '2023-09-26'),
    ('user15n', '2023-09-26');
   -- Inserting 10 additional rows into the Users table
INSERT INTO Users (Username, CreatedAt)
VALUES
    ('user16', '2023-09-26'),
    ('user17', '2023-09-26'),
    ('user18', '2023-09-26'),
    ('user19', '2023-09-26'),
    ('user20', '2023-09-26'),
    ('user21', '2023-09-26'),
    ('user22', '2023-09-26'),
    ('user23', '2023-09-26'),
    ('user24', '2023-09-26'),
    ('user25', NULL);

-- Insertion into Photos table. 5 rows.
INSERT INTO Photos (ImageURL, UserID, PublicationDate) VALUES
    ('https://first1.com/photo1.jpg', 1, '2023-09-26'),
    ('https://second1.com/photo2.jpg', 2, '2023-09-26'),
    ('https://third1.com/photo3.jpg', 3, '2023-09-27'),
    ('https://fourth1.com/photo4.jpg', 4, '2023-09-27'),
    ('https://fifth1.com/photo5.jpg', 5, '2023-09-28'),
    ('https://epa.gov/pellentesque/at/nulla.html', 6, '2023-05-12'),
    ('http://java.com/tortor/eu/pede.html', 7, '2023-05-22'),
    ('https://devhub.com/nunc/vestibulum.js', 8, '2022-11-04'),
    ('https://plala.or.jp/cubilia/curae/nulla/dapibus/dolor/vel.aspx', 9, '2023-02-20'),
    ('http://sciencedirect.com/odio/curabitur/convallis.png', 10, '2023-05-31'),
    ('http://instagram.com/in/quis/justo.png', 11, '2023-04-18'),
    ('http://smh.com.au/ac/nulla/sed/vel/enim/sit/amet.xml', 12, '2023-07-28'),
    ('http://1688.com/diam/neque/vestibulum.json', 13, '2023-03-09'),
    ('http://homestead.com/praesent/blandit/lacinia/erat.jsp', 14, '2023-05-06'),
    ('http://umn.edu/in/tempor/turpis/nec/euismod.json', 15, NULL);

-- Inserting 10 additional rows into the Photos table
INSERT INTO Photos (ImageURL, UserID, PublicationDate) VALUES
    ('https://photo11.com/image1.jpg', 16, '2023-10-01'),
    ('https://photo12.com/image2.jpg', 17, '2023-10-02'),
    ('https://photo13.com/image3.jpg', 18, '2023-10-03'),
    ('https://photo14.com/image4.jpg', 19, '2023-10-04'),
    ('https://photo15.com/image5.jpg', 20, '2023-10-05'),
    ('https://photo16.com/image6.jpg', 21, '2023-10-06'),
    ('https://photo17.com/image7.jpg', 22, '2023-10-07'),
    ('https://photo18.com/image8.jpg', 23, NULL), -- Inserting a null value for the publication Date
    ('https://photo19.com/image9.jpg', 24, '2023-10-09'),
    (NULL, NULL, NULL);

-- Insertion into Likes table. Simulating photos with varying likes.
INSERT INTO Likes (UserID, PhotoID, DateOfLike)
VALUES
    (1, 3, '2023-09-26'),  -- User 1 liked Photo 3
    (2, 3, '2023-09-26'),  -- User 2 liked Photo 3
    (3, 4, '2023-09-27'),  -- User 3 liked Photo 4
    (4, 5, '2023-09-27'),  -- User 4 liked Photo 5
    (5, 6, '2023-09-28'),  -- User 5 liked Photo 6
    (6, 6, '2023-09-29'),  -- User 6 liked their own Photo 6
    (7, 7, '2023-09-30'),  -- User 7 liked their own Photo 7
    (8, 8, '2023-10-01'),  -- User 8 liked their own Photo 8
    (9, 9, '2023-10-02'),  -- User 9 liked their own Photo 9
    (10, 10, '2023-10-03'), -- User 10 liked their own Photo 10
    (11, 12, '2023-10-04'), -- User 11 liked Photo 12
    (12, 13, '2023-10-05'), -- User 12 liked Photo 13
    (13, 14, '2023-10-06'), -- User 13 liked Photo 14
    (14, 15, '2023-10-07'), -- User 14 liked Photo 15
    (15, 16, '2023-10-08'), -- User 15 liked Photo 16
    (16, 17, '2023-10-09'), -- User 16 liked Photo 17
    (17, 18, '2023-10-10'), -- User 17 liked Photo 18
    (18, 19, '2023-10-11'), -- User 18 liked Photo 19
    (19, 20, '2023-10-12'), -- User 19 liked Photo 20
    (20, 21, '2023-10-13'), -- User 20 liked Photo 21
    (21, 22, '2023-10-14'), -- User 21 liked Photo 22
    (22, 23, '2023-10-15'), -- User 22 liked Photo 23
    (23, 24, '2023-10-16'), -- User 23 liked Photo 24
    (24, 25, '2023-10-17'), -- User 24 liked Photo 25
    (25, 25, '2023-10-17');  -- User 25 liked their own Photo 25

-- Insert into the Follow table.
INSERT INTO Follow (follower_id, followee_id, follow_date) VALUES
    (1, 1, '2023-09-26'),
    (2, 2, '2023-09-26'),
    (3, 3, '2023-09-26');

-- Insertion using mockaroo.
INSERT INTO Follow (follower_id, followee_id, follow_date) VALUES
    (4, 4, '2023-04-04'),
    (5, 5, '2022-11-14'),
    (6, 6, '2022-11-14'),
    (7, 7, '2022-11-14'),
    (8, 8, '2023-05-25'),
    (9, 9, '2023-03-15'),
    (10, 10, '2023-05-04'),
    (11, 11, '2022-10-19'),
    (12, 12, '2023-09-26'),
    (13, 13, '2023-07-19'),
    (14, 14, '2023-04-16'),
    (15, 15, '2023-04-09');

-- Inserting 10 additional rows into the Follow table with follower and followee IDs from 16 to 25
INSERT INTO Follow (follower_id, followee_id, follow_date) VALUES
    (16, 16, '2023-10-11'), -- User 16 follows User 17
    (17, 17, '2023-10-12'), -- User 17 follows User 18
    (18, 18, '2023-10-13'), -- User 18 follows User 19
    (19, 19, '2023-10-14'), -- User 19 follows User 20
    (20, 20, '2023-10-15'), -- User 20 follows User 21
    (21, 21, '2023-10-16'), -- User 21 follows User 22
    (22, 22, '2023-10-17'), -- User 22 follows User 23
    (23, 23, '2023-10-18'), -- User 23 follows User 24
    (24, 24, '2023-10-19'), -- User 24 follows User 25
    (25, 25, '2023-10-20'); -- User 25 follows user 25

-- Adding foreign key constraints to link the tables

-- Adding a foreign key constraint to link the Photos table to the Users table
ALTER TABLE Photos
ADD CONSTRAINT FK_Photos_Users
FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- Adding a foreign key constraint to link the Likes table to the Users table
ALTER TABLE Likes
ADD CONSTRAINT FK_Likes_Users
FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- Adding a foreign key constraint to link the Likes table to the Photos table
ALTER TABLE Likes
ADD CONSTRAINT FK_Likes_Photos
FOREIGN KEY (PhotoID)
REFERENCES Photos(PhotoID);

-- Creating a compound primary key for the Likes table using UserID and PhotoID
ALTER TABLE Likes
ADD CONSTRAINT PK_Likes
PRIMARY KEY (UserID, PhotoID);

-- Adding a unique constraint to ensure usernames remain unique
ALTER TABLE Users
ADD CONSTRAINT UQ_Username
UNIQUE (Username);

-- Displaying the tables
SELECT * FROM Users;
SELECT * FROM Photos;
SELECT * FROM Likes;
SELECT * FROM Follow;

-- Retrieving the usernames of users who liked a specific photo with PhotoID 3

-- Selecting the Username column from the Users table
SELECT Users.Username
FROM Likes
-- Joining the Likes and Users tables based on the UserID column
JOIN Users ON Likes.UserID = Users.UserID
-- Joining the Likes table to the Users table using the UserID column as the link
WHERE Likes.PhotoID = 3;

-- Retrieving the usernames of users who followed a specific user (follower) with FollowerID 3
SELECT Users.Username
FROM Follow
JOIN Users ON Follow.follower_id = Users.UserID
WHERE Follow.follower_id = 3;

-- Retrieving the usernames of users who liked a specific photo (e.g., PhotoID 3) before a specific date (e.g., '2023-09-01')
SELECT Users.Username
FROM Likes
JOIN Users ON Likes.UserID = Users.UserID
WHERE Likes.PhotoID = 3
-- Specifying a condition to filter the results to likes before a specific date ('jake_jackson', '2023-09-26')
AND Likes.DateOfLike < '2023-10-10';

-- Question 1: Get the usernames of users with at least one follower.
SELECT U.Username AS User_Name
FROM Users U
WHERE EXISTS (
  SELECT 1
  FROM Follow F
  WHERE F.followee_id = U.UserID
);

-- Question 2: Retrieve the image_url of photos liked by one specific user (you can decide which one).
SELECT DISTINCT P.ImageURL AS Liked_Photo_URL
FROM Photos P
JOIN Likes L ON P.PhotoID = L.PhotoID
JOIN Users U ON L.UserID = U.UserID
WHERE U.Username = 'user3';

-- Question 3: Find the usernames of users who have not posted any photos.
SELECT U.Username AS User_Name
FROM Users U
LEFT JOIN Photos P ON U.UserID = P.UserID
WHERE P.PhotoID IS NULL;

-- Question 4: Retrieve the usernames of users who have liked their own photos.
SELECT DISTINCT U.Username AS User_Name
FROM Users U
JOIN Likes L ON U.UserID = L.UserID
JOIN Photos P ON L.PhotoID = P.PhotoID
WHERE P.UserID = U.UserID AND L.UserID = P.UserID;



-- Question 5: List the usernames of users who have posted photos but have not received any likes.
SELECT U.Username AS User_Name
FROM Users U
JOIN Photos P ON U.UserID = P.UserID
LEFT JOIN Likes L ON P.PhotoID = L.PhotoID
WHERE L.PhotoID IS NULL;

-- Question 6: Retrieve the usernames of users who have posted photos and received likes.
SELECT DISTINCT U.Username AS User_Name
FROM Users U
JOIN Photos P ON U.UserID = P.UserID
JOIN Likes L ON P.PhotoID = L.PhotoID;

-- Question 7: Get the usernames of users who have usernames with more than 10 characters.
SELECT Username
FROM Users
WHERE LENGTH(Username) > 10;

-- Question 8: Retrieve the usernames of users who have usernames ending with the letter 'n'.
SELECT Username
FROM Users
WHERE RIGHT(Username, 1) = 'n';

-- Question 9: Use the replace function to replace values in the username attribute.
UPDATE Users
SET Username = REPLACE(REPLACE(Username, 'user20', 'user(20)'), 'user21', 'user(21)');

SELECT * FROM Users;





