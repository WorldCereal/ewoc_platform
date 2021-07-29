#!/bin/bash

local HOSTNAME="auth.185.178.85.22"

### Add keycloak Service 
curl -kSsl -X POST \
--url https://localhost:8444/services/ \
--data 'name=keycloak' \
--data 'url=http://'$HOSTNAME':80'

### Add keycloak route

curl -kSsl -X POST \
--url https://localhost:8444/services/keycloak/routes \
--data 'hosts[]='$HOSTNAME \
--data 'paths[]=/' \
--data 'strip_path=false' \

touch toto.test