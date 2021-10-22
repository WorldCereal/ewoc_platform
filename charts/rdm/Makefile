.PHONY: build deploy_postgres delete_postgres delete_rdm deploy_pgadmin deploy_rdm

build:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Create env and secret for pulling image
	@kubectl apply -f init.yaml 

deploy_postgres:
	# deploy oidc plugin for RDM 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Deploy postgres
	@helm install rdm-postgres bitnami/postgresql --values postgres/values.yaml -n rdm

deploy_rdm:
	# template value backend
	@sed "s:VALUE1:$(HOSTNAME):g" rdmapi/values.tmpl > rdmapi/values.yaml

	# Deploy Backend
	helm install rdmapi rdmapi/ -f rdmapi/values.yaml -n rdm

	# template value frontend
	@sed "s:VALUE1:$(HOSTNAME):" rdmui/values.tmpl > rdmui/values.yaml

	# Deploy FrontEnd
	helm install rdmui bitnami/nginx --values rdmui/values.yaml -n rdm

	# Ingress
	@sed "s:VALUE1:$(HOSTNAME):g" ingress.tmpl > ingress.yaml
	@kubectl apply -f ingress.yaml -n rdm 

	# waiting 10 secondes before install oidc plugin
	sleep 10

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm-ingress.00/plugins \
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
	# PgAdmin 
	



delete_postgres:

delete_rdm:
	@helm uninstall -n rdm rdmui