## run

docker compose up -d 

docker compose exec mc /bin/sh


## common command

mc alias list

mc ls local

mc tree local

mc rb local/testbucket

mc stat local/mybucket

mc admin user add local newuser newpassword


## summary

•	mc ls — list buckets or objects
•	mc mb — make bucket
•	mc cp — copy/upload/download
•	mc rm — remove object
•	mc rb — remove bucket
•	mc tree — folder-like structure
•	mc mirror — sync folders
•	mc stat — metadata
•	mc alias set — configure endpoints
•	mc admin — advanced server management

