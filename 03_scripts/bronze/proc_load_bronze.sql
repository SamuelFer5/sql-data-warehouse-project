/*
===============================================================================
Procedimiento Almacenado: Carga de Capa Bronze (Origen -> Bronze)
===============================================================================
Propósito del Script:
    Este procedimiento almacenado carga datos en el esquema 'bronze' desde 
    archivos CSV externos. Realiza las siguientes acciones:
    - Trunca las tablas bronze antes de cargar los datos.
    - Utiliza el comando `BULK INSERT` para cargar datos desde archivos CSV 
      hacia las tablas bronze.

Parámetros:
    Ninguno. 
    Este procedimiento almacenado no acepta parámetros ni devuelve valores.

Ejemplo de uso:
    EXEC bronze.load_bronze;
===============================================================================
*/
USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Cargando Capa Bronze';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Cargando Tablas CRM';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Insertando Datos en: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Insertando Datos en: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Insertando Datos en: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        PRINT '------------------------------------------------';
        PRINT 'Cargando Tablas ERP';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Insertando Datos en: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Insertando Datos en: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncando Tabla: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Insertando Datos en: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\samue\Desktop\BD AVANZADAS\sql-data-warehouse-project\01_datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duracion de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
        PRINT '>> -------------';

        SET @batch_end_time = GETDATE();
        PRINT '==========================================';
        PRINT 'Carga de Capa Bronze Completada';
        PRINT '   - Duracion Total: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos';
        PRINT '==========================================';
    END TRY
    BEGIN CATCH
        PRINT '==========================================';
        PRINT 'ERROR OCURRIDO DURANTE LA CARGA DE LA CAPA BRONZE';
        PRINT 'Mensaje de Error: ' + ERROR_MESSAGE();
        PRINT 'Numero de Error: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Estado de Error: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH
END
GO
