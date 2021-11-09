.PHONY: deploy delete

host=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_host"] ' | base64 --decode )
port=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_port"] ' | base64 --decode ) 
dbname=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_database"] ' | base64 --decode )
user=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_user"] ' | base64 --decode )
password=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_password"] ' | base64 --decode )

deploy:
	# Deploy WCTiler 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	# Init env
	@kubectl apply -f init.yaml
	
	@sed "s:VALUE1:$(HOSTNAME):" ingress.tmpl > ingress.yaml

	# Create pgsql connexion conf
	#@sed "s:HOST:$(host):;s:PORT:$(port):;s:DBNAME:$(dbname):;s:USER:$(user):;s:PASSWORD:$(password):" chart/config/mapfiles/postgres_connection.inc.map.tmpl > chart/config/mapfiles/postgres_connection.inc.map.sample
	@sed "s:HOST:postgres-postgresql-0.postgres-postgresql-headless.argo.svc.cluster.local:;s:PORT:$(port):;s:DBNAME:world-cereal-wctiler:;s:USER:$(user):;s:PASSWORD:$(password):" chart/config/mapfiles/postgres_connection.inc.map.tmpl > chart/config/mapfiles/postgres_connection.inc.map.sample

	@helm install mapproxy  chart/  --namespace=wctiler --wait  --set-file mapserver.mapfiles.postgresConnection=chart/config/mapfiles/postgres_connection.inc.map.sample

	# create ingress for WCTiller
	@kubectl apply -f ingress.yaml -n wctiler

	# waiting 10 secondes before install oidc plugin
	sleep 10

	# install oidc plugin on wctiller route
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/wctiler.wctiler.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=wctiler' \
	--data 'config.client_secret=2738c0a4-85be-44b0-8784-125b0ec8feac' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/wctiler.wctiler.01/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=wctiler' \
	--data 'config.client_secret=2738c0a4-85be-44b0-8784-125b0ec8feac' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

delete :
	# Delete WCTiller
	@kubectl delete ingress -n wctiler wctiler
	@helm uninstall  mapproxy -n wctiler

