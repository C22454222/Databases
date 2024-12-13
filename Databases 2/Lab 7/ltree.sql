-- Create the extension if not exists
CREATE EXTENSION IF NOT EXISTS ltree;

-- Drop the existing 'tud' table if it exists
DROP TABLE IF EXISTS tud;

-- Create the 'tud' table with path as an ltree data type
CREATE TABLE tud (path ltree);

-- Insert the initial data
INSERT INTO tud VALUES ('TUD');
INSERT INTO tud VALUES ('TUD.Art');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.ProductDesign');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.FineArts');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.InteriorDesign');
INSERT INTO tud VALUES ('TUD.Art.Food');
INSERT INTO tud VALUES ('TUD.Art.Food.CulinaryArts');
INSERT INTO tud VALUES ('TUD.Art.Food.Baking');
INSERT INTO tud VALUES ('TUD.Art.Turism');
INSERT INTO tud VALUES ('TUD.Art.Turism.EventManagment');
INSERT INTO tud VALUES ('TUD.Art.Turism.TurismMarketing');
INSERT INTO tud VALUES ('TUD.Art.Languages_Law_SocialScience');
INSERT INTO tud VALUES ('TUD.Art.Languages_Law_SocialScience.InternationaBusinessLanguage');
INSERT INTO tud VALUES ('TUD.Art.Media');
INSERT INTO tud VALUES ('TUD.Art.Media.GameDesign');
INSERT INTO tud VALUES ('TUD.Art.Media.FilmBroadcasting');
INSERT INTO tud VALUES ('TUD.Art.Conservatory');
INSERT INTO tud VALUES ('TUD.Art.Conservatory.Composition');
INSERT INTO tud VALUES ('TUD.Business');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance.BusinessFinance');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance.Macroeconomics');
INSERT INTO tud VALUES ('TUD.Business.Marketing');
INSERT INTO tud VALUES ('TUD.Business.Marketing.MarketingPractice');
INSERT INTO tud VALUES ('TUD.Business.Marketing.InternationalMarketing');
INSERT INTO tud VALUES ('TUD.Business.Management');
INSERT INTO tud VALUES ('TUD.Business.Management.Logistics');
INSERT INTO tud VALUES ('TUD.Business.Management.SupplyChainManagement');
INSERT INTO tud VALUES ('TUD.Business.Retail');
INSERT INTO tud VALUES ('TUD.Business.Retail.RetailAnalytics');
INSERT INTO tud VALUES ('TUD.Business.Retail.RetailMarketing');
INSERT INTO tud VALUES ('TUD.Science');
INSERT INTO tud VALUES ('TUD.Science.Pharmaceutical_Chemistry_Forensic.Biotechnology');
INSERT INTO tud VALUES ('TUD.Science.Pharmaceutical_Chemistry_Forensic.BasicMicrobiology');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience.MolecularBiology');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience.ScientificProject');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition.FoodMicrobiology');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition.Food_Beverage');
INSERT INTO tud VALUES ('TUD.Science.HealthCare');
INSERT INTO tud VALUES ('TUD.Science.HealthCare.OpticalDispensing');
INSERT INTO tud VALUES ('TUD.Science.HealthCare.BinocularVision');
INSERT INTO tud VALUES ('TUD.Science.Physics');
INSERT INTO tud VALUES ('TUD.Science.Physics.Relativity');
INSERT INTO tud VALUES ('TUD.Science.Physics.QuantumMechanics');
INSERT INTO tud VALUES ('TUD.Science.Mathematics');
INSERT INTO tud VALUES ('TUD.Science.Mathematics.Geometry');
INSERT INTO tud VALUES ('TUD.Science.Mathematics.RealAnalisys');
INSERT INTO tud VALUES ('TUD.Science.Computing');
INSERT INTO tud VALUES ('TUD.Science.Computing.Databases');
INSERT INTO tud VALUES ('TUD.Science.Computing.CloudComputing');
INSERT INTO tud VALUES ('TUD.Engineering');
INSERT INTO tud VALUES ('TUD.Engineering.BuiltEngineering.AutomitiveManagement');
INSERT INTO tud VALUES ('TUD.Engineering.BuiltEngineering.PropertyStudies');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture.ArchitecturalTechnology');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture.ConstrutionStieManagement');
INSERT INTO tud VALUES ('TUD.Engineering.StructuralEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.StructuralEngineering.CivilEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology.Modelling');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology.BIM');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering.ElectricalPower');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering.Control');
INSERT INTO tud VALUES ('TUD.Engineering.Transport');
INSERT INTO tud VALUES ('TUD.Engineering.Transport.SpatialPlanning');
INSERT INTO tud VALUES ('TUD.Engineering.Transport.LocalDevelopment');
INSERT INTO tud VALUES ('TUD.Engineering.Design');
INSERT INTO tud VALUES ('TUD.Engineering.Design.DesignInnovation');
INSERT INTO tud VALUES ('TUD.Engineering.Design.CreativeDesignStudio');
INSERT INTO tud VALUES ('TUD.Engineering.Pippo.pdf');

-- Create indexes for faster querying
CREATE INDEX path_gist_idx ON tud USING gist(path);
CREATE INDEX path_idx ON tud USING btree(path);

-- Show all paths from the 4th node of length 4, descendant of 'TUD.ART' (=school of art)
SELECT subpath(path, 3) FROM tud WHERE path <@ 'TUD.Art' and nlevel(path)=4;

-- Select the root node
SELECT subpath(path,0,1) FROM tud where nlevel(path)=1;

-- Count the number of schools for each college
SELECT subpath(path,1,1) AS "College",count(subpath(path,2,1)) AS "Number of Schools"
FROM tud
WHERE nlevel(path) = 3								   
GROUP BY subpath(path,1,1);

-- Add a new school named Computer_Science under the TUD.Science college
INSERT INTO tud (path) VALUES ('TUD.Science.Computer_Science');

-- Add two new degrees to the Computer_Science school: software and AI
INSERT INTO tud (path) VALUES ('TUD.Science.Computer_Science.software');
INSERT INTO tud VALUES ('TUD.Science.Computer_Science.AI');

-- a) Find under which degree the MolecularBiology degree is
SELECT subpath(path, 3) 
FROM tud 
WHERE path <@ 'TUD.Science.BiologicalScience.MolecularBiology';

-- b) Find how many courses are listed in the TUD dataset
SELECT COUNT(*) 
FROM tud 
WHERE nlevel(path) = 4;

-- c) Find which faculty has the highest number of courses
SELECT subpath(path, 2, 1) AS "Faculty", COUNT(*) AS "Number of Courses"
FROM tud
WHERE nlevel(path) = 4
GROUP BY subpath(path, 2, 1)
ORDER BY COUNT(*) DESC
LIMIT 1;

-- d) How many colleges are in the TUD dataset?
SELECT COUNT(DISTINCT subpath(path, 1, 1)) 
FROM tud 
WHERE nlevel(path) = 2;

-- e) Rename the university TUDublin (all the paths containing the label TUD must be replaced by the new label TUDublin)
UPDATE tud
SET path = REGEXP_REPLACE(path::text, '^TUD', 'TUDublin')::ltree;

-- f) Delete the school of BiologicalScience with all its courses
DELETE FROM tud
WHERE path <@ 'TUDublin.Science.BiologicalScience';

-- g) Add a column CAO points to the TUD table (integer)
ALTER TABLE tud ADD COLUMN cao_points INTEGER;

-- h) Add 300 CAO points to all the degrees under the Art College, 450 to the degrees under the Science College,
-- 400 to the Engineering College, and the remaining assign 350
UPDATE tud SET cao_points = 300
WHERE path <@ 'TUDublin.Art' AND nlevel(path) = 4;

UPDATE tud SET cao_points = 450
WHERE path <@ 'TUDublin.Science' AND nlevel(path) = 4;

UPDATE tud SET cao_points = 400
WHERE path <@ 'TUDublin.Engineering' AND nlevel(path) = 4;

UPDATE tud SET cao_points = 350
WHERE nlevel(path) = 4 AND cao_points IS NULL;

-- Assign 500 CAO points to the degrees in the School of Computer Science
UPDATE tud SET cao_points = 500
WHERE path <@ 'TUDublin.Science.Computer_Science' AND nlevel(path) = 4;

SELECT AVG(cao_points) AS average_cao_points 
FROM tud 
WHERE path <@ 'TUDublin.Science' 
AND nlevel(path) = 4
AND cao_points IS NOT NULL;


