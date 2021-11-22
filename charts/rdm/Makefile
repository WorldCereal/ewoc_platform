.PHONY: init build deploy_postgres delete_postgres delete_rdm deploy_pgadmin deploy_rdm delete_pg_admin

build: 
	@helm repo add runix https://helm.runix.net

init:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Create env and secret for pulling image
	@kubectl apply -f init.yaml 

deploy_postgres:
	# deploy oidc plugin for RDM 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Deploy postgres
	@helm install rdm bitnami/postgresql --version 10.9.4 --values postgres/values_main.yaml -n rdm
	@helm install rdm-cdb bitnami/postgresql --version 10.9.4 --values postgres/values_cdb.yaml -n rdm
	@helm install rdm-rdb bitnami/postgresql --version 10.9.4 --values postgres/values_rdb.yaml -n rdm

deploy_rdm:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# template value backend
	@sed "s:VALUE1:$(HOSTNAME):g" rdmapi/values.tmpl > rdmapi/values.yaml

	# Deploy Backend
	@helm install rdmapi rdmapi/ -f rdmapi/values.yaml -n rdm

	# template value frontend
	@sed "s:VALUE1:$(HOSTNAME):" rdmui/values.tmpl > rdmui/values.yaml

	# Deploy FrontEnd
	@helm install rdmui bitnami/nginx --values rdmui/values.yaml -n rdm

	# Ingress
	@sed "s:VALUE1:$(HOSTNAME):g" ingress.tmpl > ingress.yaml
	@kubectl apply -f ingress.yaml -n rdm 

	# waiting 10 secondes before install oidc plugin
	sleep 10

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.$(HOSTNAME)/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.$(HOSTNAME)'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm.01/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.$(HOSTNAME)/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.$(HOSTNAME)'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdmapiingress.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

deploy_pgadmin:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# PgAdmin 	
	@helm install pgadmin runix/pgadmin4 -f pgadmin/values.yaml -n rdm

	# Ingress
	@sed "s:VALUE1:$(HOSTNAME):g" pgadmin/ingress.tmpl > pgadmin/ingress.yaml
	@kubectl apply -f pgadmin/ingress.yaml -n rdm

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.pgadmin-pgadmin4.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

delete_postgres:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@helm delete rdm -n rdm
	@helm delete rdm-cdb -n rdm
	@helm delete rdm-rdb -n rdm


delete_rdm:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@helm uninstall -n rdmui rdmui
	@helm uninstall -n rdmapi rdmui
	@kubectl delete -n rdm ingress rdm 
	@kubectl delete -n rdm ingress rdmapiingress 

delete_pg_admin:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@helm delete -n rdm pgadmin
	@kubectl delete -n rdm ingress pgadmin-pgadmin4 

run_rdmDbMigrate_job:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	@kubectl apply -f jobs/job_dbMigrate.yml -n rdm

run_rdmRefDbUpdate_job:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	@kubectl apply -f jobs/job_refUpdate.yml -n rdm

delete_rdmDbMigrate_job:
	@kubectl delete job -n rdm rdm-db-migrator

delete_rdmRefDbUpdate_job:
	@kubectl delete job -n rdm rdm-refdb-updator