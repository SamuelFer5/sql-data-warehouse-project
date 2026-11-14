/*
===============================================================================
Chequeos de Completitud y Esquema - Capa Bronze
===============================================================================
Propósito del Script:
    Este script realiza validaciones sobre la capa 'bronze' después de ejecutar
    el procedimiento `bronze.load_bronze`:
    - Verifica que las 6 tablas existan en el esquema 'bronze' y revisa sus columnas.
    - Cuenta el total de registros cargados en cada tabla para validar la completitud
      frente a los archivos CSV originales.
    - Muestra una vista previa (TOP 10) de cada tabla para verificar que las columnas
      no se hayan desplazado durante el BULK INSERT.
===============================================================================
*/
USE DataWarehouse;
GO

-- ====================================================================
-- 1. Verificación de Esquema y Tablas Creadas en 'bronze'
-- ====================================================================
SELECT 
    t.name AS nombre_tabla,
    c.column_id AS orden_columna,
    c.name AS nombre_columna,
    ty.name AS tipo_dato,
    c.max_length AS longitud_maxima
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE s.name = 'bronze'
ORDER BY t.name, c.column_id;
GO

-- ====================================================================
-- 2. Conteo de Filas (Data Completeness Check)
-- ====================================================================
SELECT 'bronze.crm_cust_info'     AS tabla, COUNT(*) AS total_filas FROM bronze.crm_cust_info
UNION ALL
SELECT 'bronze.crm_prd_info'      AS tabla, COUNT(*) AS total_filas FROM bronze.crm_prd_info
UNION ALL
SELECT 'bronze.crm_sales_details' AS tabla, COUNT(*) AS total_filas FROM bronze.crm_sales_details
UNION ALL
SELECT 'bronze.erp_cust_az12'     AS tabla, COUNT(*) AS total_filas FROM bronze.erp_cust_az12
UNION ALL
SELECT 'bronze.erp_loc_a101'      AS tabla, COUNT(*) AS total_filas FROM bronze.erp_loc_a101
UNION ALL
SELECT 'bronze.erp_px_cat_g1v2'   AS tabla, COUNT(*) AS total_filas FROM bronze.erp_px_cat_g1v2;
GO

-- ====================================================================
-- 3. Inspección Visual de Datos Cargados (Muestra por Tabla)
-- ====================================================================
SELECT TOP 10 * FROM bronze.crm_cust_info;
SELECT TOP 10 * FROM bronze.crm_prd_info;
SELECT TOP 10 * FROM bronze.crm_sales_details;
SELECT TOP 10 * FROM bronze.erp_cust_az12;
SELECT TOP 10 * FROM bronze.erp_loc_a101;
SELECT TOP 10 * FROM bronze.erp_px_cat_g1v2;
GO
