#!/bin/bash


### Add Keycloak Service  #### keycloak.local
curl -kSsl -X POST \
--url https://localhost:8444/services/ \
--data 'name=keycloak' \
--data 'url=http://keycloak.local:80'

### Add Keycloak route ####

curl -kSsl -X POST \
--url https://localhost:8444/services/keycloak/routes \
--data 'hosts[]=185.178.85.22'
--data 'paths[]=/auth' \
--data 'strip_path=false' \


### Add Grafana Service ###

### Add Grafana routes ###

### Add Grafana Service ###

### Add Grafana routes ###

