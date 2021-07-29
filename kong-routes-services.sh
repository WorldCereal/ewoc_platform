#!/bin/bash


### Add keycloak Service 
curl -kSsl -X POST \
--url https://localhost:8444/services/ \
--data 'name=keycloak' \
--data 'url=http://185.178.85.22:80/auth"'

### Add keycloak route

curl -kSsl -X POST \
--url https://localhost:8444/services/keycloak/routes \
--data 'paths[]=/auth"' \
--data 'strip_path=false' \

touch toto.test