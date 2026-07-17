CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_duration DATETIME,@end_duration DATETIME;
	DECLARE @start_batch_duration DATETIME,@end_batch_duration DATETIME;
	BEGIN TRY
		SET @start_batch_duration = GETDATE()
		PRINT '============================================';
		PRINT '            LOADING BRONZE LAYER            ';
		PRINT '============================================';

		PRINT '--------------------------------------------';
		PRINT '               LOAD CRM TABLES              ';
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting data into : bronze.crm_cust_info'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting data into : bronze.crm_prd_info'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting data into : bronze.crm_sales_details'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK
		);
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';

		PRINT '--------------------------------------------';
		PRINT '               LOAD ERP TABLES              ';
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting data into : bronze.erp_cust_az12'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.erp_cust_az12 
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting data into : bronze.erp_loc_a101'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.erp_loc_a101 
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';

		PRINT '>> Truncating table : bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting data into : bronze.erp_px_cat_g1v2'
		SET @start_duration = GETDATE()
		BULK INSERT bronze.erp_px_cat_g1v2 
		FROM 'C:\Users\zouba\OneDrive\Desktop\DATA WITH BARA DOCS\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_duration = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_duration,@end_duration) AS NVARCHAR) + ' milliseconds'
		PRINT '--------------------------------------------';
		SET @end_batch_duration = GETDATE()
		PRINT '--------------------------------------------';
		PRINT '>> Total Load Duration : ' + CAST(DATEDIFF(MILLISECOND,@start_batch_duration,@end_batch_duration) AS NVARCHAR)+  ' milliseconds';
	END TRY
	BEGIN CATCH
		PRINT '--------------------------------------------';
		PRINT '             ERROR LOADING BRONZE           ';
		PRINT '--------------------------------------------';
		PRINT '>> Error Message :' + ERROR_MESSAGE()
		PRINT '>> Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR)
	END CATCH
END
GO
EXEC bronze.load_bronze;
