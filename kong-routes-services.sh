#!/bin/bash


### Add Keycloak Service  #### keycloak.local
curl -kSsl -X POST \
--url https://localhost:8444/services/ \
--data 'name=keycloak' \
--data 'host=keycloak.keycloak.http.svc' \
--data 'port=80' \
--data 'path=/' \
--data 'protocols=http' 



### Add Keycloak route ####

curl -kSsl -X POST \
--url https://localhost:8444/services/keycloak/routes \
--data 'hosts[]=185.178.85.22'
--data 'paths[]=/auth' \
--data 'strip_path=false' \
--data 'protocols[]=http' \
--data 'preserve_host:false'


### Add Grafana Service ###

### Add Grafana routes ###

### Add Grafana Service ###

### Add Grafana routes ###


#curl -kSsl -X DELETE --url https://localhost:8444/services/keycloak/routes/3f6ea64b-66c4-4248-a956-f58384305793




