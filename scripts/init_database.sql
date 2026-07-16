/*
======================================================================
		                DATABASE AND SCHEMAS
======================================================================
Purpose :
this script will create the database and the schemas for each layer.

Warning:
- running this script will drop "DataWarehouse" database if it exists
- all data in the database will be completly lost

*/

USE master;

--Verify if the database already exists and drop it
DROP DATABASE IF EXISTS DataWarehouse;

GO

--Create the database 
CREATE DATABASE DataWarehouse;

GO

USE DataWarehouse;

GO

--Create the bronze layer schema
CREATE SCHEMA bronze;

GO 
--Create the silver layer schema
CREATE SCHEMA silver;

GO
--Create the gold layer schema
CREATE SCHEMA gold;

