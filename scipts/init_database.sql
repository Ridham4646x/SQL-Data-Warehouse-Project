/* 
==================================================================
Create Database and Schemas
==================================================================

Script Purpose:
	Below code drops the database named 'DataWarehouse' if exists and create a new database.

	It create 3 new schemas in DataWarehouse database'
	1.bronze
	2.Silver
	3.Gold

Warning :⛔
	Run this code with Causion 
	If you running below code on your machine . If you have your person data base name 'DataWarehouse' that drops/ delets.
	So, backup your old schema and then run this code.

*/

use master;
go

-- Drop and recreate the 'DataWarehouse' database

drop database DateWarehouse;
go

--Creating a brand new database
create database DateWarehouse;
go
use DateWarehouse;

--Creating Schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go
