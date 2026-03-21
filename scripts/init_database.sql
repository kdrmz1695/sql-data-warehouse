/*
=========================================
Create Database and Schemas
=========================================
This script creating database and schemas. If the database already exists it will drop the entire 'DataWarehouse' database
and will create new one
*/

USE master;
GO
-- DROP and recreate the database

IF EXISTS ( SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO
--Create Database

CREATE DATABASE DataWarehouse
GO
USE DataWarehouse;
GO
-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO