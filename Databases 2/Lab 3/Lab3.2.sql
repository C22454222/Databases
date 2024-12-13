-- Drop existing tables if they exist to ensure a clean setup
DROP TABLE IF EXISTS OLD_PATIENT_DATA; -- Table for storing historical patient data
DROP TABLE IF EXISTS PATIENTS; -- Table for storing current patient data

-- Create the PATIENTS table to store current patient information
CREATE TABLE PATIENTS (
    patient_id SERIAL PRIMARY KEY, -- Unique identifier for each patient (auto-incremented)
    date DATE NOT NULL, -- Date of the record
    patient_fname VARCHAR(20) NOT NULL, -- Patient's first name (required)
    patient_lname VARCHAR(20) NOT NULL, -- Patient's last name (required)
    age INTEGER NOT NULL, -- Patient's age (required)
    weight NUMERIC(5,2) NOT NULL, -- Patient's weight in kg with up to two decimal places
    height NUMERIC(5,2) NOT NULL, -- Patient's height in cm with up to two decimal places
    bmi NUMERIC(4,2) NOT NULL -- Patient's BMI (calculated automatically)
);

-- Create a function to calculate the BMI before inserting or updating a patient record
CREATE OR REPLACE FUNCTION calculate_bmi()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate BMI as weight (kg) divided by height squared (m²)
    NEW.bmi := NEW.weight / ((NEW.height / 100) * (NEW.height / 100));
    RETURN NEW; -- Return the modified record with the calculated BMI
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the calculate_bmi function before inserting or updating records in the PATIENTS table
CREATE TRIGGER update_bmi
BEFORE INSERT OR UPDATE ON PATIENTS
FOR EACH ROW 
EXECUTE FUNCTION calculate_bmi();

-- Create the OLD_PATIENT_DATA table to store historical data of patients
CREATE TABLE OLD_PATIENT_DATA (
    patient_id INTEGER, -- Reference to the patient in the PATIENTS table
    record_id SERIAL, -- Unique identifier for each historical record of a patient
    date DATE NOT NULL, -- Date of the historical record
    age INTEGER NOT NULL, -- Age of the patient at the time of the record
    weight NUMERIC(5,2) NOT NULL, -- Weight of the patient at the time of the record
    height NUMERIC(5,2) NOT NULL, -- Height of the patient at the time of the record
    bmi NUMERIC(4,2) NOT NULL, -- BMI of the patient at the time of the record
    PRIMARY KEY (patient_id, record_id), -- Composite primary key (patient_id + record_id)
    FOREIGN KEY (patient_id) REFERENCES PATIENTS(patient_id) -- Foreign key to link to the PATIENTS table
);

-- Create a function to store the old data into the OLD_PATIENT_DATA table before updating the PATIENTS table
CREATE OR REPLACE FUNCTION store_old_data()
RETURNS TRIGGER AS $$
DECLARE 
    next_record_id INTEGER; -- Variable to hold the next record ID for the patient
BEGIN
    -- Determine the next record ID for the given patient
    SELECT COALESCE(MAX(record_id), 0) + 1 INTO next_record_id
    FROM old_patient_data
    WHERE patient_id = OLD.patient_id;

    -- Insert the old data into the OLD_PATIENT_DATA table
    INSERT INTO old_patient_data (patient_id, record_id, date, age, weight, height, bmi)
    VALUES (OLD.patient_id, next_record_id, OLD.date, OLD.age, OLD.weight, OLD.height, OLD.bmi);

    RETURN OLD; -- Proceed with the update on the PATIENTS table
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the store_old_data function before updating records in the PATIENTS table
CREATE TRIGGER store_old_data_trigger
BEFORE UPDATE ON PATIENTS
FOR EACH ROW 
EXECUTE FUNCTION store_old_data();

-- Insert sample data into the PATIENTS table
INSERT INTO patients (date, patient_fname, patient_lname, age, weight, height)
VALUES ('2024-01-01', 'John','Blog', 48, 71, 175); -- Add patient John Blog with specific details

INSERT INTO patients (date, patient_fname, patient_lname, age, weight, height)
VALUES('2024-03-01', 'Mary', 'Stuart', 24, 56, 172); -- Add patient Mary Stuart with specific details

-- Update the weight of patient with ID 1 (John Blog)
UPDATE patients
SET weight = 72
WHERE patient_id = 1;

-- Update the height of patient with ID 2 (Mary Stuart)
UPDATE patients
SET height = 173
WHERE patient_id = 2;

-- Query to display all records in the PATIENTS table
SELECT * FROM patients;

-- Query to display all records in the OLD_PATIENT_DATA table
SELECT * FROM old_patient_data;
