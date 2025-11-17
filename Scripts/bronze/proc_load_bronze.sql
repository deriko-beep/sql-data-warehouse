/*
===================================================================================================================
                                               Stored procedure
                          Bulk Load data from the Source into the Bronze layer Tables
===================================================================================================================
Script purpose:
This stored procedure loads data into the Bronze schema from the external CSV files.
It performs the following actions:

- Truncates the bronze tables before loading data.
- Uses BULK insert command to load data

Parameters: None. This stored procedure does not accept any parameters or return any value.

Command: EXEC bronze.load_bronze

*/

USE [Claridon_DWH]
GO

/****** Object:  StoredProcedure [bronze].[load_bronze]    Script Date: 11/17/2025 11:31:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [bronze].[load_bronze] AS

BEGIN

	DECLARE @start_time DATETIME, @end_time DATETIME, @start_batch_time DATETIME, @end_batch_time DATETIME;
	BEGIN TRY
		SET @start_batch_time = GETDATE();

		PRINT '=============================================================================================';
		PRINT 'Loading the Bronze Layer';
		PRINT '=============================================================================================';

		PRINT '---------------------------------------------------------------------------------------------';
		PRINT 'Loading the CRM Tables';
		PRINT '---------------------------------------------------------------------------------------------';

		set @start_time = GETDATE();


		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.crm_cust_info <<<<<<<<<';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>>>>>>>Inset=rting data into bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Data Warehouse\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);


		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.crm_prd_info <<<<<<<<<';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>>>>>>>Inset=rting data into bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Data Warehouse\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.sales_details <<<<<<<<<';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>>>>>>>>Inserting data into bronze.sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Data Warehouse\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:' + cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
		PRINT '-----------------------------------------------------------------'


		PRINT '---------------------------------------------------------------------------------------------';
		PRINT 'Loading the ERP Tables';
		PRINT '---------------------------------------------------------------------------------------------';

		set @start_time = GETDATE();

		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.erp_cust_az12 <<<<<<<<<';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>>>>>>>>Inserting data into bronze.CUST_AZ12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Data Warehouse\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.erp_loc_a101 <<<<<<<<<';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>>>>>>>>Inserting data into bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Data Warehouse\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		PRINT '>>>>>>>>TRUNCATING THE TABLE: bronze.erp_px_cat_giv2 <<<<<<<<<';
		TRUNCATE TABLE bronze.erp_px_cat_giv2

		PRINT '>>>>>>>>Inserting data into bronze.erp_px_cat_giv2';
		BULK INSERT bronze.erp_px_cat_giv2
		FROM 'C:\Data Warehouse\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration:' + cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
	PRINT '----------------------------------
	'
	SET @end_batch_time = GETDATE();
	PRINT '==================================================================================='
	PRINT 'Loading Bronze layer is Completed';
	PRINT '    Total Load Duration : ' + CAST(DATEDIFF(second, @start_batch_time, @end_batch_time)AS NVARCHAR) + 'Seconds';

	END TRY
	BEGIN CATCH
		PRINT '============================================================================'
		PRINT 'SORRY, ERROR OCCURED DURING LOADING BRONZE LAYER...CHECK AND RETRY'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + cast(error_message() as nvarchar);
		PRINT 'Error Message' + cast(error_state() as nvarchar);
		PRINT '============================================================================'

	END CATCH;
END;
GO


