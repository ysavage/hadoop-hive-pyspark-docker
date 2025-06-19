
-- Creating a detabases for the assessment
CREATE DATABASE assessment_boneAge_analysis;

USE DATABASE assessment_boneAge_analysis; -- Select created database.

-- Defining Bone Age schema for hive data warehouse
CREATE TABLE boneage_anal_data (id INT, boneage INT, male BOOLEAN) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- Load the CSV into Hive
-- hdfs dfs -put boneage-dataset\ 1.csv /user/hive/warehouse/

-- Then load it into the table
LOAD DATA INPATH '/home/jovyan/work/data/boneage-dataset.csv' INTO TABLE boneage_anal_data;

-- Upload Images to HDFS - Store images in HDFS, since hive is not ideal for storing such data.
-- hdfs dfs -mkdir /user/hive/warehouse/boneage_images
-- hdfs dfs -put *.png /user/hive/warehouse/boneage_images/

-- Create a Hive Table for Image Metadata
CREATE TABLE boneage_anal_images (id INT, image_path STRING);

-- Then load load automated metadata CSV into the table
LOAD DATA INPATH '/home/jovyan/work/data/boneage-dataset.csv' INTO TABLE boneage_anal_data;

-- Join Image Metadata with Bone Age Data
SELECT d.id, d.boneage, d.male, i.image_path FROM boneage_data d JOIN boneage_images i ON d.id = i.id;
