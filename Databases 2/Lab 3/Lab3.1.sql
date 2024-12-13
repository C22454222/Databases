-- Drop existing tables and functions (cleanup for redefinition)
DROP TABLE IF EXISTS LOGTEAM;
DROP TABLE IF EXISTS EUROLEAGUE;
DROP TABLE IF EXISTS MATCHES;
DROP TABLE IF EXISTS TEAMS;
DROP FUNCTION IF EXISTS log_team_insertion_and_add_to_euroleague();

-- Create TEAMS table
CREATE TABLE TEAMS (
    TeamName VARCHAR(20) PRIMARY KEY, -- Unique identifier for each team
    TeamCountry VARCHAR(20) NOT NULL, -- Country of the team (required field)
    CONSTRAINT check_country CHECK (TeamCountry IN ('Spain', 'England')) -- Restricts allowed countries to Spain or England
);

-- Create MATCHES table
CREATE TABLE MATCHES (
    MatchID SERIAL PRIMARY KEY, -- Unique identifier for each match (auto-incremented)
    TeamA_Name VARCHAR(20) REFERENCES TEAMS(TeamName), -- Team A's name, referencing TEAMS table
    TeamB_Name VARCHAR(20) REFERENCES TEAMS(TeamName), -- Team B's name, referencing TEAMS table
    Goal_A INTEGER NOT NULL CHECK (Goal_A >= 0), -- Goals scored by Team A (non-negative)
    Goal_B INTEGER NOT NULL CHECK (Goal_B >= 0), -- Goals scored by Team B (non-negative)
    Competition VARCHAR(20) NOT NULL, -- Type of competition (required field)
    CONSTRAINT check_competition CHECK (Competition IN ('Champions League', 'Europa League', 'Premier League', 'LaLiga')) -- Restricts competition types
);

-- Create EUROLEAGUE table
CREATE TABLE EUROLEAGUE (
    TeamName VARCHAR(20) PRIMARY KEY REFERENCES TEAMS(TeamName), -- Team name, referencing TEAMS table
    Points INTEGER NOT NULL, -- Total points (initially 0)
    Goals_scored INTEGER NOT NULL, -- Total goals scored (initially 0)
    Goals_conceded INTEGER NOT NULL, -- Total goals conceded (initially 0)
    Difference INTEGER NOT NULL -- Goal difference (initially 0)
);

-- Create LOGTEAM table to store team insertion logs
CREATE TABLE LOGTEAM (
    LogID SERIAL PRIMARY KEY, -- Unique identifier for each log entry (auto-incremented)
    TeamName VARCHAR(20) NOT NULL, -- Name of the team that was inserted
    InsertionTimestamp TIMESTAMP NOT NULL -- Timestamp of the insertion
);

-- Create a trigger function to log insertions into TEAMS and add to EUROLEAGUE
CREATE OR REPLACE FUNCTION log_team_insertion_and_add_to_euroleague()
RETURNS TRIGGER AS $$
BEGIN
    -- Log the team insertion into LOGTEAM
    INSERT INTO LOGTEAM (TeamName, InsertionTimestamp)
    VALUES (NEW.TeamName, CURRENT_TIMESTAMP);

    -- Add the team to the EUROLEAGUE table with initial stats, if not already present
    INSERT INTO EUROLEAGUE (TeamName, Points, Goals_scored, Goals_conceded, Difference)
    VALUES (NEW.TeamName, 0, 0, 0, 0)
    ON CONFLICT (TeamName) DO NOTHING; -- Prevents duplicate entries for the same team

    RETURN NEW; -- Proceed with the insertion into TEAMS
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to invoke the logging function after team insertions
CREATE TRIGGER log_team_insertion_and_add_to_euroleague_trigger
AFTER INSERT ON TEAMS
FOR EACH ROW
EXECUTE FUNCTION log_team_insertion_and_add_to_euroleague();

-- Create a trigger function to enforce country restrictions for matches
CREATE OR REPLACE FUNCTION check_team_countries()
RETURNS TRIGGER AS $$
DECLARE
    team_a_country VARCHAR(20); -- Variable to store Team A's country
    team_b_country VARCHAR(20); -- Variable to store Team B's country
BEGIN
    -- Fetch the countries of Team A and Team B
    SELECT TeamCountry INTO team_a_country FROM TEAMS WHERE TeamName = NEW.TeamA_Name;
    SELECT TeamCountry INTO team_b_country FROM TEAMS WHERE TeamName = NEW.TeamB_Name;

    -- Ensure both teams belong to the same country for specific competitions
    IF NEW.Competition = 'Premier League' AND (team_a_country != 'England' OR team_b_country != 'England') THEN
        RAISE EXCEPTION 'Both teams must be from England for Premier League matches';
    ELSIF NEW.Competition = 'LaLiga' AND (team_a_country != 'Spain' OR team_b_country != 'Spain') THEN
        RAISE EXCEPTION 'Both teams must be from Spain for LaLiga matches';
    END IF;

    RETURN NEW; -- Proceed with the match insertion
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to invoke the country validation function before match insertions
CREATE TRIGGER check_team_countries_trigger
BEFORE INSERT ON MATCHES
FOR EACH ROW
EXECUTE FUNCTION check_team_countries();

-- Create a trigger function to check match count and update EUROLEAGUE stats
CREATE OR REPLACE FUNCTION check_match_count_and_update_euroleague()
RETURNS TRIGGER AS $$
DECLARE
    match_count_a INT; -- Variable to store match count for Team A
    match_count_b INT; -- Variable to store match count for Team B
BEGIN
    -- Count the number of matches Team A has participated in
    SELECT COUNT(*) INTO match_count_a FROM MATCHES 
    WHERE TeamA_Name = NEW.TeamA_Name OR TeamB_Name = NEW.TeamA_Name;

    -- Count the number of matches Team B has participated in
    SELECT COUNT(*) INTO match_count_b FROM MATCHES 
    WHERE TeamA_Name = NEW.TeamB_Name OR TeamB_Name = NEW.TeamB_Name;

    -- Restrict any team from participating in more than 4 matches
    IF match_count_a >= 4 OR match_count_b >= 4 THEN
        RAISE EXCEPTION 'A team cannot have more than 4 matches';
    END IF;

    -- Update the EUROLEAGUE stats based on match results
    IF NEW.Goal_A > NEW.Goal_B THEN
        -- Team A wins
        UPDATE EUROLEAGUE SET 
            Points = Points + 3, 
            Goals_scored = Goals_scored + NEW.Goal_A,
            Goals_conceded = Goals_conceded + NEW.Goal_B,
            Difference = Difference + (NEW.Goal_A - NEW.Goal_B)
        WHERE TeamName = NEW.TeamA_Name;

        UPDATE EUROLEAGUE SET 
            Goals_scored = Goals_scored + NEW.Goal_B,
            Goals_conceded = Goals_conceded + NEW.Goal_A,
            Difference = Difference - (NEW.Goal_A - NEW.Goal_B)
        WHERE TeamName = NEW.TeamB_Name;

    ELSIF NEW.Goal_B > NEW.Goal_A THEN
        -- Team B wins
        UPDATE EUROLEAGUE SET 
            Points = Points + 3, 
            Goals_scored = Goals_scored + NEW.Goal_B,
            Goals_conceded = Goals_conceded + NEW.Goal_A,
            Difference = Difference + (NEW.Goal_B - NEW.Goal_A)
        WHERE TeamName = NEW.TeamB_Name;

        UPDATE EUROLEAGUE SET 
            Goals_scored = Goals_scored + NEW.Goal_A,
            Goals_conceded = Goals_conceded + NEW.Goal_B,
            Difference = Difference - (NEW.Goal_B - NEW.Goal_A)
        WHERE TeamName = NEW.TeamA_Name;

    ELSE
        -- Draw
        UPDATE EUROLEAGUE SET 
            Points = Points + 1, 
            Goals_scored = Goals_scored + NEW.Goal_A,
            Goals_conceded = Goals_conceded + NEW.Goal_B
        WHERE TeamName IN (NEW.TeamA_Name, NEW.TeamB_Name);
    END IF;

    RETURN NEW; -- Proceed with the match insertion
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to invoke the match count and stats update function before match insertions
CREATE TRIGGER check_match_count_and_update_euroleague_trigger
BEFORE INSERT ON MATCHES
FOR EACH ROW
EXECUTE FUNCTION check_match_count_and_update_euroleague();

-- Insert initial teams into TEAMS
INSERT INTO TEAMS (TeamName, TeamCountry) VALUES
('Arsenal', 'England'),
('Manchester City', 'England'),
('Manchester United', 'England'),
('Chelsea', 'England'),
('Real Madrid', 'Spain'),
('Barcelona', 'Spain'),
('Atletico Madrid', 'Spain'),
('Sevilla', 'Spain');

-- Insert matches into MATCHES
INSERT INTO MATCHES (TeamA_Name, TeamB_Name, Goal_A, Goal_B, Competition) VALUES
('Arsenal', 'Manchester City', 2, 1, 'Premier League'),
('Real Madrid', 'Barcelona', 3, 3, 'LaLiga'),
('Manchester United', 'Chelsea', 0, 2, 'Premier League'),
('Atletico Madrid', 'Sevilla', 1, 0, 'LaLiga');

-- Query to view teams
SELECT * FROM TEAMS;

-- Query to view team insertion logs
SELECT * FROM LOGTEAM;

-- Query to view matches
SELECT * FROM MATCHES;

-- Query to view EUROLEAGUE standings
SELECT * FROM EUROLEAGUE;
