-- Pruebas de validacion para las vistas de la capa Gold
USE DataWarehouse;
GO

-- 1. Verificar que customer_key sea unico en gold.dim_customers (esperado: sin resultados)
SELECT 
    customer_key,
    COUNT(*) AS cantidad
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;
GO

-- 2. Verificar que product_key sea unico en gold.dim_products (esperado: sin resultados)
SELECT 
    product_key,
    COUNT(*) AS cantidad
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;
GO

-- 3. Verificar integridad referencial entre fact_sales y las dimensiones (esperado: sin resultados)
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;
GO
