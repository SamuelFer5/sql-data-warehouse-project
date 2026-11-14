-- Procedimiento almacenado para cargar los CSV en la capa Bronze
-- Uso: EXEC bronze.load_bronze;

USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT 'Iniciando carga de Capa Bronze...';

        -- Tablas CRM
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.crm_cust_info cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.crm_prd_info cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.crm_sales_details cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        -- Tablas ERP
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.erp_loc_a101 cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.erp_cust_az12 cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'bronze.erp_px_cat_g1v2 cargada en ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seg';

        SET @batch_end_time = GETDATE();
        PRINT 'Carga de Capa Bronze completada en ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos.';
    END TRY
    BEGIN CATCH
        PRINT 'Error durante la carga de Bronze: ' + ERROR_MESSAGE();
    END CATCH
END
GO
