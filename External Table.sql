CREATE DATABASE SCOPED CREDENTIAL cred_naga
WITH 
    IDENTITY = 'Managed Identity'


Create external data source source_gold
WITH
(
    location ='https://adventureadls.dfs.core.windows.net/gold',
    CREDENTIAL = cred_naga
)

CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
FORMAT_TYPE = PARQUET,
DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

--- CREATE EXTERNAL TBALE EXTSALES

CREATE EXTERNAL TABLE gold.extsales
WITH
(
    LOCATION = 'extsales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)AS 
SELECT * FROM gold.sales

select * from gold.extsales