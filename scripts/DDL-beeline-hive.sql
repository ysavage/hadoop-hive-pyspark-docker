
-- DATA DEFINATION COMMANDS - DDL
-- Creating a detabases for the assessment
CREATE DATABASE assessment_boneAge_analysis; 
SHOW DATABASES; -- Show databases

USE assessment_boneAge_analysis; -- Select created database.

-- Defining Bone Age schema for hive data warehouse 
CREATE TABLE boneage_anal_data (idx INT, id INT, boneage INT, male BOOLEAN) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- Load the CSV into Hive
-- hdfs dfs -put boneage-dataset\ 1.csv /user/hive/warehouse/

-- Then load it into the table
LOAD DATA LOCAL INPATH '/data/boneage-inages/boneage_dataset.csv'INTO TABLE boneage_anal_data;

-- Upload Images to HDFS - Store images in HDFS, since hive is not ideal for storing such data.
-- hdfs dfs -mkdir /user/hive/warehouse/boneage_images
-- hdfs dfs -put *.png /user/hive/warehouse/boneage_images/

-- Create a Hive Table for Image Metadata
CREATE TABLE boneage_anal_images (id INT, image_path STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- ??? Table was initially set-up to store data manually there received multiple error messages
-- Was deleted and recreated with additional clause to handle  script to generate: ????
INSERT INTO boneage_anal_images VALUES (1377, '/opt/data/boneage-images/1377.png');
LOAD DATA LOCAL INPATH '/data/boneage-images/boneage_images.csv' INTO TABLE boneage_anal_images;

-- Join Image Metadata with Bone Age Data
SELECT d.id, d.boneage, d.male, i.image_path FROM boneage_anal_data d JOIN boneage_anal_images i ON d.id = i.id;

-- DATA MANUPILATION COMMANDS - DML
USE assessment_boneAge_analysis;
SHOW TABLES;

SELECT * FROM boneage_anal_data LIMIT 10; -- Print 10 rows of table data
SELECT * FROM boneage_anal_images LIMIT 10; -- Print 10 rows of table data
SELECT COUNT(*) AS total_records FROM boneage_anal_data; -- Print 10 rows of table data

-- Overview of Min, Max, Average, STCD
SELECT MIN(boneage) AS min_boneage, MAX(boneage) AS max_boneage, AVG(boneage) AS avg_boneage, STDDEV(boneage) AS stddev_boneage FROM boneage_anal_data;
-- Total Entry by Gender
SELECT male, COUNT(*) AS count FROM boneage_anal_data GROUP BY male;
-- Average BoneAge by Groups
SELECT male, AVG(boneage) AS avg_boneage FROM boneage_anal_data GROUP BY male;
-- Show table record where boneage is between 18 & 216 months
SELECT * FROM boneage_anal_data WHERE boneage < 18 OR boneage > 216;


