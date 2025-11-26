
### run 
docker-compose run --rm duckdb

or 

docker run --rm -it -v "$(pwd):/workspace" -w /workspace -p 4213:4213 duckdb/duckdb

###### set S3 connection variables

SET s3_region = 'us-east-1';
SET s3_endpoint = '192.168.1.4:9000';
SET s3_access_key_id = 'admin';
SET s3_secret_access_key = 'admin123';
SET s3_use_ssl = false;
SET s3_url_style = 'path'; 

### examples

SELECT *
  FROM read_parquet('s3://ut-datalake/bronze/bubi/account/ds=2025-11-15/part-*.parquet')
  LIMIT 200;


DESCRIBE
SELECT *
FROM read_parquet('s3://ut-datalake/bronze/bubi/account/ds=2025-11-15/*.parquet');

