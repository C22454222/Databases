-- Drop tables in reverse order of dependencies
DROP TABLE IF EXISTS E7;
DROP TABLE IF EXISTS E8;
DROP TABLE IF EXISTS E5_E6_Relationship;
DROP TABLE IF EXISTS E5;
DROP TABLE IF EXISTS E6;
DROP TABLE IF EXISTS E4;
DROP TABLE IF EXISTS E3;
DROP TABLE IF EXISTS E1;
DROP TABLE IF EXISTS E2;

-- Create table for E2 (the "many" side of the relationship)
CREATE TABLE E2 (
    K2 INT PRIMARY KEY -- Primary key for E2
);

-- Create table for E1 (the "one" side of the relationship)
CREATE TABLE E1 (
    K1 INT PRIMARY KEY, -- Primary key for E1
    K2 INT NOT NULL, -- Foreign key referencing E2
    CONSTRAINT fk_e2 FOREIGN KEY (K2) REFERENCES E2(K2) ON DELETE CASCADE
);

-- Create table for E3 (the "(0,1)" side of the relationship)
CREATE TABLE E3 (
    K3 INT PRIMARY KEY -- Primary key for E3
);

-- Create table for E4 (the "(0,*)" side of the relationship)
CREATE TABLE E4 (
    K4 INT PRIMARY KEY, -- Primary key for E4
    K3 INT, -- Foreign key referencing E3, can be NULL
    CONSTRAINT fk_e3 FOREIGN KEY (K3) REFERENCES E3(K3) ON DELETE SET NULL
);

-- Create table for E5 (one side of the relationship)
CREATE TABLE E5 (
    K5 INT PRIMARY KEY -- Primary key for E5
);

-- Create table for E6 (the other side of the relationship)
CREATE TABLE E6 (
    K6 INT PRIMARY KEY -- Primary key for E6
);

-- Create a junction table to model the many-to-many relationship
CREATE TABLE E5_E6_Relationship (
    E5_id INT, -- Foreign key referencing E5
    E6_id INT, -- Foreign key referencing E6
    PRIMARY KEY (E5_id, E6_id), -- Composite primary key
    CONSTRAINT fk_e5 FOREIGN KEY (E5_id) REFERENCES E5(K5) ON DELETE CASCADE,
    CONSTRAINT fk_e6 FOREIGN KEY (E6_id) REFERENCES E6(K6) ON DELETE CASCADE
);

-- Create table for E8
CREATE TABLE E8 (
    K8 INT PRIMARY KEY -- Primary key for E8
);

-- Create table for E7 (the child in the one-to-one side of the relationship)
CREATE TABLE E7 (
    K7 INT PRIMARY KEY, -- Primary key for E7
    K8 INT NOT NULL, -- Foreign key referencing E8, must be NOT NULL to enforce the (1,1) constraint
    CONSTRAINT fk_e8 FOREIGN KEY (K8) REFERENCES E8(K8) ON DELETE CASCADE
);