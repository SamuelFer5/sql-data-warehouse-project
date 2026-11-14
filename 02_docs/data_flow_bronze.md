# Flujo de Datos y Documentación - Capa Bronze

Este documento describe el flujo de ingesta de datos desde los sistemas de origen (**CRM** y **ERP**) hacia la **Capa Bronze** del almacén de datos (`DataWarehouse`) en SQL Server.

---

## 1. Diagrama de Flujo de Datos (Capa Bronze)

```mermaid
flowchart LR
    subgraph Fuentes["Fuentes de Datos (Archivos CSV)"]
        direction TB
        subgraph CRM["Sistema CRM (01_datasets/source_crm)"]
            c1["📄 cust_info.csv"]
            c2["📄 prd_info.csv"]
            c3["📄 sales_details.csv"]
        end
        subgraph ERP["Sistema ERP (01_datasets/source_erp)"]
            e1["📄 CUST_AZ12.csv"]
            e2["📄 LOC_A101.csv"]
            e3["📄 PX_CAT_G1V2.csv"]
        end
    end

    subgraph Bronze["Capa Bronze (Esquema: bronze)"]
        direction TB
        sp["⚙️ Stored Procedure:\nbronze.load_bronze\n(Truncate & Bulk Insert)"]
        b1[("🗄️ bronze.crm_cust_info")]
        b2[("🗄️ bronze.crm_prd_info")]
        b3[("🗄️ bronze.crm_sales_details")]
        b4[("🗄️ bronze.erp_cust_az12")]
        b5[("🗄️ bronze.erp_loc_a101")]
        b6[("🗄️ bronze.erp_px_cat_g1v2")]
    end

    c1 -->|BULK INSERT| b1
    c2 -->|BULK INSERT| b2
    c3 -->|BULK INSERT| b3
    e1 -->|BULK INSERT| b4
    e2 -->|BULK INSERT| b5
    e3 -->|BULK INSERT| b6
```

---

## 2. Detalle de Tablas e Ingesta en Capa Bronze

| Sistema Origen | Archivo CSV | Tabla Destino (Bronze) | Método de Carga | Transformaciones |
| :--- | :--- | :--- | :--- | :--- |
| **CRM** | `cust_info.csv` | `bronze.crm_cust_info` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |
| **CRM** | `prd_info.csv` | `bronze.crm_prd_info` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |
| **CRM** | `sales_details.csv` | `bronze.crm_sales_details` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |
| **ERP** | `CUST_AZ12.csv` | `bronze.erp_cust_az12` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |
| **ERP** | `LOC_A101.csv` | `bronze.erp_loc_a101` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |
| **ERP** | `PX_CAT_G1V2.csv` | `bronze.erp_px_cat_g1v2` | `TRUNCATE` + `BULK INSERT` | Ninguna (Datos en bruto) |

---

## 3. Relaciones entre Entidades de Origen

```mermaid
erDiagram
    crm_sales_details }o--|| crm_prd_info : "sls_prd_key -> prd_key"
    crm_sales_details }o--|| crm_cust_info : "sls_cust_id -> cst_id"
    crm_prd_info ||--o| erp_px_cat_g1v2 : "prd_key -> id"
    crm_cust_info ||--o| erp_cust_az12 : "cst_key -> cid"
    crm_cust_info ||--o| erp_loc_a101 : "cst_key -> cid"
```
