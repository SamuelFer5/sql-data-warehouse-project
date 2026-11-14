-- Pruebas de calidad de datos para la capa Silver
USE DataWarehouse;
GO

-- 1. Revisar silver.crm_cust_info
-- Buscar duplicados o nulos en la clave primaria (esperado: sin resultados)
SELECT 
    cst_id,
    COUNT(*) AS cantidad
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Buscar espacios en blanco sobrantes (esperado: sin resultados)
SELECT cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Revisar valores estandarizados
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;
GO

-- 2. Revisar silver.crm_prd_info
-- Buscar duplicados o nulos en prd_id (esperado: sin resultados)
SELECT 
    prd_id,
    COUNT(*) AS cantidad
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Buscar costos negativos o nulos (esperado: sin resultados)
SELECT prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Buscar fechas de fin menores a la fecha de inicio (esperado: sin resultados)
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;
GO

-- 3. Revisar silver.crm_sales_details
-- Buscar ordenes con fechas incoherentes (esperado: sin resultados)
SELECT * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Verificar que ventas = cantidad * precio (esperado: sin resultados)
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0;
GO

-- 4. Revisar silver.erp_cust_az12
-- Verificar que no haya fechas de nacimiento futuras
SELECT DISTINCT bdate 
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

-- Verificar valores de genero
SELECT DISTINCT gen FROM silver.erp_cust_az12;
GO

-- 5. Revisar silver.erp_loc_a101
-- Verificar nombres de paises estandarizados
SELECT DISTINCT cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;
GO
