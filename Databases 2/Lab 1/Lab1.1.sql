-- Drop existing tables if they exist
DROP TABLE IF EXISTS toy_attributes;
DROP TABLE IF EXISTS toys;

-- Create main toys table
CREATE TABLE toys (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create toy_attributes table with an explicit foreign key constraint
CREATE TABLE toy_attributes (
    id SERIAL PRIMARY KEY,
    toy_id INT NOT NULL,
    attribute_name VARCHAR(50) NOT NULL,
    attribute_value VARCHAR(255) NOT NULL,
    UNIQUE (toy_id, attribute_name),
    FOREIGN KEY (toy_id) REFERENCES toys(id) ON DELETE CASCADE
);

-- Insert sample data for toys and attributes
INSERT INTO toys (name, price) VALUES ('Toy Car', 19.99);
INSERT INTO toy_attributes (toy_id, attribute_name, attribute_value) VALUES 
    (1, 'engine_size', '1.5L'),
    (1, 'petrol_or_diesel', 'petrol');

INSERT INTO toys (name, price) VALUES ('Teddy Bear', 14.99);
INSERT INTO toy_attributes (toy_id, attribute_name, attribute_value) VALUES 
    (2, 'material', 'cotton'),
    (2, 'age', '3+');

-- Select core toy data
SELECT * FROM toys;

-- Select specific attributes for each toy
SELECT * FROM toy_attributes;

-- Join toys and attributes to view complete data
SELECT t.id, t.name, t.price, ta.attribute_name, ta.attribute_value
FROM toys t
LEFT JOIN toy_attributes ta ON t.id = ta.toy_id;
