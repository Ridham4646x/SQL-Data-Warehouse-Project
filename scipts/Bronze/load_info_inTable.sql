--Adding raw data / Full load to our empty table with 'BULK INSERT' command🏺

--If same script runs twise , same data adding twisly to same table causes ERROR so we uee TRUNCATE before every bulk insert📢

/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_timee DATETIME;
	
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		print'~~~~~~~~~~~~'
	-- -----------------------------------------------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'
	-- -----------------------------------------------------------------------------------------------------------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'

	-- -----------------------------------------------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_crm\sales_details.CSV'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'
	-- -----------------------------------------------------------------------------------------------------------------------------------------


		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

	-- -----------------------------------------------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_CUST_AZ12'
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		PRINT '>> Inserting Data Into: bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'

	-- -----------------------------------------------------------------------------------------------------------------------------------------


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_LOC_A101'
		TRUNCATE TABLE bronze.erp_LOC_A101;

		PRINT '>> Inserting Data Into: bronze.erp_LOC_A101'
		BULK INSERT bronze.erp_LOC_A101
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'

		-- -----------------------------------------------------------------------------------------------------------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2'
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		PRINT '>> Inserting Data Into: bronze.erp_PX_CAT_G1V2'
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'D:\SQL\My Projects\sql-data-warehouse-project by baraa Sir\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print'Load Duration :' + CAST(DATEDIFF(second,@start_time, @end_time)AS VARCHAR)+ 'seconds'

		SET @batch_start_time = GETDATE();
		print'Bronze layer batch load is Complited !! YEEE'

		print'Bronze Batch Load Duration :' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time)AS VARCHAR)+ 'seconds'
		print'~~~~~~~~~~~~'

-- -----------------------------------------------------------------------------------------------------------------------------------------

	END TRY
	BEGIN CATCH
		PRINT'========================================================'
		PRINT'ERROR OCUURED DURING LOADING BRONZE LAYER'
		PRINT'Error Message' + ERROR_MESSAGE();
		PRINT'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT'========================================================'
	END CATCH
END;
GO

-- from here RUN🏃‍♂️ whole query
EXEC bronze.load_bronze
GO

