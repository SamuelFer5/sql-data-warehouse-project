# Flujo de datos - Capa Bronze

En la capa Bronze se cargan los 6 archivos CSV de los sistemas CRM y ERP directamente en tablas de SQL Server sin hacerles cambios, usando `TRUNCATE TABLE` y `BULK INSERT` dentro del procedimiento `bronze.load_bronze`.

## Diagrama de flujo

```mermaid
flowchart LR
    subgraph CRM["source_crm"]
        c1["cust_info.csv"]
        c2["prd_info.csv"]
        c3["sales_details.csv"]
    end

    subgraph ERP["source_erp"]
        e1["CUST_AZ12.csv"]
        e2["LOC_A101.csv"]
        e3["PX_CAT_G1V2.csv"]
    end

    subgraph Bronze["Esquema bronze"]
        b1["bronze.crm_cust_info"]
        b2["bronze.crm_prd_info"]
        b3["bronze.crm_sales_details"]
        b4["bronze.erp_cust_az12"]
        b5["bronze.erp_loc_a101"]
        b6["bronze.erp_px_cat_g1v2"]
    end

    c1 --> b1
    c2 --> b2
    c3 --> b3
    e1 --> b4
    e2 --> b5
    e3 --> b6
```

## Tablas de origen y destino

| Origen | Archivo CSV | Tabla en Bronze |
| :--- | :--- | :--- |
| CRM | `cust_info.csv` | `bronze.crm_cust_info` |
| CRM | `prd_info.csv` | `bronze.crm_prd_info` |
| CRM | `sales_details.csv` | `bronze.crm_sales_details` |
| ERP | `CUST_AZ12.csv` | `bronze.erp_cust_az12` |
| ERP | `LOC_A101.csv` | `bronze.erp_loc_a101` |
| ERP | `PX_CAT_G1V2.csv` | `bronze.erp_px_cat_g1v2` |
