
-- DATA MANUPILATION COMMANDS - DML
USE assessment_boneAge_analysis;
SHOW TABLES;

SELECT * FROM boneage_anal_data LIMIT 10; -- Print 10 rows of table data
SELECT * FROM boneage_anal_images LIMIT 10; -- Print 10 rows of table data
SELECT COUNT(*) AS total_records FROM boneage_anal_data; -- Print 10 rows of table data

-- Overview of Min, Max, Average, STCD
SELECT MIN(boneage) AS min_boneage, MAX(boneage) AS max_boneage, AVG(boneage) AS avg_boneage, STDDEV(boneage) AS stddev_boneage FROM boneage_data;
-- Total Entry by Gender
SELECT male, COUNT(*) AS count FROM boneage_anal_data GROUP BY male;
-- Average BoneAge by Groups
SELECT male, AVG(boneage) AS avg_boneage FROM boneage_anal_data GROUP BY male;
-- Assuming you have computed the thresholds externally
SELECT * FROM boneage_anal_data WHERE boneage < 18 OR boneage > 216;