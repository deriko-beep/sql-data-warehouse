/*
===============================================================================================================
                                      Create Database and schemas
===============================================================================================================
                                            Script purpose:
  This script creates a new database called Claridon after checking if it EXISTS.
  If the Database Exists it is dropped and recreated. Addidtionally, the script sets up three Schemas within
  the Databse namely...: 'Bronze', 'Silver', and 'Gold'.

                                              WARNING!!!!!
  Running this script will dropthe entire Claridon_DWH database if it exists  and all the datain the database will
  be deleted permanently. Proceed with caution and ensure you have a backup

===============================================================================================================

*/


USE master;
GO

--We drop and create the Claridon_Dwh Database
IF EXIST SELECT 1 FROM sys.databases WHERE name = 'Claridon_DWH')
BEGIN
  ALTER DATABASE Claridon_DWH SET SINGLE USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE Claridon_DWH;
END;
GO

--Creating the main DataBase and making it current(active)
CREATE DATABASE Claridon_DWH;
GO
  
USE Claridon_DWH;

--Creating schemas in the current Databaset keep things organised
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
