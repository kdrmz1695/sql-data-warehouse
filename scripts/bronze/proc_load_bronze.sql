/*
=============================================================
Stored Procedure: Load Bronze Layer
=============================================================
This stored procedure load data into the bronze schema from external CSV files.
 1- Truncates the bronze tables before loading
 2- Using the BULK INSERT command to load data from external csv files.
=============================================================
Usage Example:

EXEC bronze.load_bronze;
=============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================================';

		PRINT'------------------------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT'------------------------------------------------------';

		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating crm_cust_info'
		PRINT'------------------------------------------------------';
		TRUNCATE TABLE bronze.crm_cust_info;

		SET @start_time = GETDATE();
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds'
		PRINT'--------------------------------------------------------';

		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating crm_prd_info'
		PRINT'------------------------------------------------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(

			FIRSTROW =2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT'--------------------------------------------------------';
		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating crm_sales_details'
		PRINT'------------------------------------------------------';

		TRUNCATE TABLE bronze.crm_sales_details
		SET @start_time = GETDATE();
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds'
		PRINT'--------------------------------------------------------';
		PRINT'------------------------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT'------------------------------------------------------';

		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating erp_cust_az12'
		PRINT'------------------------------------------------------';
		TRUNCATE TABLE bronze.erp_cust_az12

		SET @start_time = GETDATE()
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE();
		PRINT '>>Loading Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT'--------------------------------------------------------';

		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating erp_loc_a101'
		PRINT'------------------------------------------------------';

		TRUNCATE TABLE bronze.erp_loc_a101

		SET @start_time = GETDATE();
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE();
		PRINT '>>Loading Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT'--------------------------------------------------------';

		PRINT'------------------------------------------------------';
		PRINT '>>>Truncating erp_px_cat_g1v2'
		PRINT'------------------------------------------------------';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\90507\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>>Loading Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT'--------------------------------------------------------';
		SET @batch_end_time = GETDATE();
		PRINT '======================================================';
		PRINT'Loading Bronze Layer is Completed';
		PRINT '======================================================';

		PRINT '======================================================';
		PRINT'<<<Total Load Duration>>>' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds'
		PRINT '======================================================';
	END TRY
	BEGIN CATCH
		PRINT '======================================================';
		PRINT 'ERROR OCCURED '
		PRINT '======================================================';
	END CATCH
END