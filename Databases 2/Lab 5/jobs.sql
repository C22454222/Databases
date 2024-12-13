-- Drop and create the tables if they exist

-- Drop persons table if it exists
DROP TABLE IF EXISTS persons;

-- Create persons table
CREATE TABLE persons (
    person_id INTEGER,
    person_name VARCHAR(20),
    person_surname VARCHAR(20),
    person_age INTEGER NULL,
    person_wealth INTEGER,
    person_weight FLOAT
);

-- Drop job_person table if it exists
DROP TABLE IF EXISTS job_person;

-- Create job_person table
CREATE TABLE job_person (
    job_id INTEGER,
    person_id INTEGER,
    start_date TIMESTAMP,
    end_date TIMESTAMP
);

-- Drop joblist table if it exists
DROP TABLE IF EXISTS joblist;

-- Create joblist table
CREATE TABLE joblist (
    job_id INTEGER,
    job_description VARCHAR(200),
    salary INTEGER
);

-- Function to populate the persons table with random data
CREATE OR REPLACE PROCEDURE Populate_table()
AS
$$
DECLARE
    v_p_id NUMERIC;
    v_p_name VARCHAR(20);
    v_p_surname VARCHAR(20);
    v_p_age INTEGER;
    p_wealth NUMERIC;
    p_weight NUMERIC;
BEGIN
    FOR i IN 1..10000 LOOP
        -- Generate random name using string aggregation
        SELECT string_agg(substring('0123456789bcdfghjkmnpqrstvwxyz', round(random() * 30)::INTEGER, 1), '')
        INTO v_p_name FROM generate_series(1, 20);
        
        -- Generate random surname using string aggregation
        SELECT string_agg(substring('0123456789bcdfghjkmnpqrstvwxyz', round(random() * 30)::INTEGER, 1), '')
        INTO v_p_surname FROM generate_series(1, 20);
        
        -- Generate random age between 18 and 100
        SELECT (18 + random() * 82)::INT INTO v_p_age;
        
        -- Generate random wealth between 0 and 1,000,000
        SELECT random() * 1000000 INTO p_wealth;
        
        -- Generate random weight between 40 and 120
        SELECT (40 + random() * 80)::INT INTO p_weight;
        
        -- Insert the generated values into the persons table
        INSERT INTO persons VALUES(i, v_p_name, v_p_surname, v_p_age, p_wealth, p_weight);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Function to populate the joblist table with random job data
CREATE OR REPLACE PROCEDURE Populate_jobs()
AS
$$
DECLARE
    j_description VARCHAR(100);
    j_salary NUMERIC;
BEGIN
    FOR i IN 1..10000 LOOP
        -- Generate random job description using string aggregation
        SELECT string_agg(substring('0123456789bcdfghjkmnpqrstvwxyz', round(random() * 30)::INTEGER, 1), '')
        INTO j_description FROM generate_series(1, 100);
        
        -- Generate random salary between 35,000 and 100,000
        SELECT (35000 + random() * 65000)::INT INTO j_salary;
        
        -- Insert the generated values into the joblist table
        INSERT INTO joblist VALUES(i, j_description, j_salary);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Function to populate the job_person table with random job assignments for persons
CREATE OR REPLACE PROCEDURE Populate_jobs_persons()
AS
$$
DECLARE
    v_p_id NUMERIC;
    start_date TIMESTAMP;
    end_date TIMESTAMP;
BEGIN
    FOR i IN 1..10000 LOOP
        FOR j IN 1..15 LOOP
            -- Generate random start and end dates within the given range
            SELECT timestamp '2004-01-10' + random() * (timestamp '2024-01-20' - timestamp '2014-01-10') INTO start_date;
            SELECT timestamp '2014-01-10' + random() * (timestamp '2024-01-20' - timestamp '2014-01-10') INTO end_date;
            
            -- Generate random person_id
            SELECT random() * 1000000 INTO v_p_id;
            
            -- Insert the generated job assignment into job_person table
            INSERT INTO job_person VALUES(i, v_p_id, start_date, end_date);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Call the procedures to populate the tables with data
CALL Populate_table();
CALL Populate_jobs();
CALL Populate_jobs_persons();

-- Example Query Optimizations

-- Query 1: EXPLAIN ANALYZE SELECT * FROM persons;
EXPLAIN ANALYZE SELECT * FROM persons;

-- Query 2: EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id > 1000 AND person_id < 3000;
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id > 1000 AND person_id < 3000;

-- Query 3: EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id >= 3;
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id >= 3;

-- Add a Primary Key to the persons table
ALTER TABLE persons ADD PRIMARY KEY (person_id);

-- Re-run Query 2 and Query 3 after adding the primary key
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id > 1000 AND person_id < 3000;
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id >= 3;

-- Query 4: EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id + 5 > 1000 AND person_id < 3000;
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id + 5 > 1000 AND person_id < 3000;

-- Query 5: EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id + 5 > 1000 AND person_id * 2 < 3000;
EXPLAIN ANALYZE SELECT * FROM persons WHERE person_id + 5 > 1000 AND person_id * 2 < 3000;

-- Query 6: EXPLAIN ANALYZE SELECT person_age, COUNT(person_id) FROM persons GROUP BY person_age;
EXPLAIN ANALYZE SELECT person_age, COUNT(person_id) FROM persons GROUP BY person_age;

-- Query 7: EXPLAIN ANALYZE SELECT person_age, COUNT(person_age) FROM persons GROUP BY person_age;
EXPLAIN ANALYZE SELECT person_age, COUNT(person_age) FROM persons GROUP BY person_age;

-- Optimized Query with Index on person_age
-- Create an index on person_age for optimized GROUP BY query
CREATE INDEX idx_person_age ON persons(person_age);

-- Re-run the optimized query with the new index
EXPLAIN ANALYZE SELECT person_age, COUNT(person_age) FROM persons GROUP BY person_age;

-- Join Query with joblist and job_person, and optimized with indexes
-- Create indexes for optimized join performance
CREATE INDEX idx_joblist_job_id ON joblist(job_id);
CREATE INDEX idx_job_person_job_id ON job_person(job_id);

-- Original Join Query
EXPLAIN ANALYZE
SELECT joblist.job_id, joblist.job_description, joblist.salary, job_person.person_id, person.person_name
FROM joblist
INNER JOIN job_person ON joblist.job_id = job_person.job_id
INNER JOIN persons person ON job_person.person_id = person.person_id
WHERE job_person.job_id = 34;

-- Optimized Join Query with indexes
EXPLAIN ANALYZE
SELECT joblist.job_id, joblist.job_description, joblist.salary, job_person.person_id
FROM joblist
INNER JOIN job_person ON joblist.job_id = job_person.job_id
WHERE job_person.job_id = 34;


