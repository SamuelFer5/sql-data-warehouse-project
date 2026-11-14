-- Consultas para validar la carga y estructura de la capa Bronze
USE DataWarehouse;
GO

-- 1. Revisar tablas y columnas creadas en el esquema bronze
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

-- 2. Contar filas cargadas en cada tabla
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

-- 3. Vista previa de las primeras 10 filas por tabla
SELECT TOP 10 * FROM bronze.crm_cust_info;
SELECT TOP 10 * FROM bronze.crm_prd_info;
SELECT TOP 10 * FROM bronze.crm_sales_details;
SELECT TOP 10 * FROM bronze.erp_cust_az12;
SELECT TOP 10 * FROM bronze.erp_loc_a101;
SELECT TOP 10 * FROM bronze.erp_px_cat_g1v2;
GO
