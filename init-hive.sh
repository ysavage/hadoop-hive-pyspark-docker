#!/bin/bash

# Wait for HiveServer2 to be ready
echo "Waiting for HiveServer2 to start..."
sleep 10

# Create a default database and a sample table, then insert sample data
hive -e "
CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;
CREATE TABLE IF NOT EXISTS employees (
    id INT,
    name STRING,
    department STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT INTO TABLE employees VALUES
(1, 'Alice', 'Engineering'),
(2, 'Bob', 'Marketing'),
(3, 'Charlie', 'Finance');

SELECT * FROM employees;
"
