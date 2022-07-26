#! /bin/sh
token=`cat client.token`

curl -X PUT -v -H "Authorization: Bearer ${token}"  -H "Content-Type: application/json" -d '{"allowedClusters": ["standalone"]}' http://127.0.0.1:8080/admin/v2/tenants/parkinglot
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/parkinglot/camera
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/parkinglot/led
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/parkinglot/finder

curl -X PUT -v -H "Authorization: Bearer ${token}"  -H "Content-Type: application/json" -d '{"allowedClusters": ["standalone"]}'  http://127.0.0.1:8080/admin/v2/tenants/cmd
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/cmd/gateway


curl -X PUT -v -H "Authorization: Bearer ${token}"  -H "Content-Type: application/json" -d '{"allowedClusters": ["standalone"]}'  http://127.0.0.1:8080/admin/v2/tenants/toilet
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/toilet/finder
curl -X PUT -v -H "Authorization: Bearer ${token}" http://127.0.0.1:8080/admin/v2/namespaces/toilet/led
