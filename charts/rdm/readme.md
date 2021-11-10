# RDM

## Deploy
To deploy this application get the code from https://github.com/WorldCereal/ewoc_rdm_deploy

Follow the following steps: 

- create namespace rdm
- create the harborcs that contains the credentials to access the harbor repository.
- Exec ```kubectl apply -f pvc.yaml -n rdm``` and ```kubectl apply -f restapi-pvc.yaml -n rdm -n rdm```
- Deploy the 3 instances of databases by running :
    - - ```helm install rdm bitnami/postgresql --version 10.9.4 --values values.yaml -n rdm```
    - - ```helm install rdm-cdb bitnami/postgresql --version 10.9.4 --values values.yaml -n rdm```
    - - ```helm install rdm-rdb bitnami/postgresql --version 10.9.4 --values values.yaml -n rdm```

- Execute the following job and wait until complete execution : ```kubectl apply -f rdmDbMigrate\job.yaml -n rdm ```

- Execute the following job and wait until complete execution : ```kubectl apply -f rdmRefDbUpdate\job.yaml -n rdm ```

- Deploy the webserver application by running : ```helm install rdmui bitnami/nginx --values rdmui/values.yaml -n rdm```

- Deploy the ingress for the application ```kubectl apply -f rdm-ingress/ingress.yaml -n rdm```
- Deploy the ingress for the rdmapi (to add manually)

- Protect the route with kong by running the following curl request on the kong-oidc-tool pods. (change url and client secret according the env) 
``` curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdmapi.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.demo.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true' 

   curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdmingress.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.demo.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.demo.worldcereal.csgroup.space/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.demo.worldcereal.csgroup.space'

    curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdmingress.01/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.demo.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.demo.worldcereal.csgroup.space/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.demo.worldcereal.csgroup.space'
```
- Deploy the pgadmin application + ingress to access it

You should have user configured with metadata on the keycloak application. 

## Update dataset

Everytime that the dataset needs to be updated you need to update 
the boolean value through the pgadmin application for the datasets that needs to be imported.

Then on the cluster, you have to delete old job and relaunch new one to load dataset in the databases.
```kubectl delete -n rdm job rdm-refUpdate(complete the name)```
```kubectl apply -f jobs.yaml -n rdm```
At the end of the job the data should be available in rdm application  




