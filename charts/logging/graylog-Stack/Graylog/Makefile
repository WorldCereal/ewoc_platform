.PHONY: build deploy delete 

password= $(shell kubectl get secrets -n logging mongo-mongodb -o json | jq  -r '.data["mongodb-password"] ' | base64 --decode )

build:
	# Build all components for Graylog
	helm repo add kongz https://charts.kong-z.com
	helm repo update
	
deploy:
	# Deploy all components for Graylog
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@sed "s:VALUE1:$(GRAYLOG_VERSION):" values_graylog.tmpl > values_graylog.yaml

	helm install graylog --namespace logging --wait kongz/graylog --version $(GRAYLOG_CHART_VERSION) \
		--set tags.install-mongodb=false \
		--set tags.install-elasticsearch=false \
		--set graylog.mongodb.uri=mongodb://graylog:$(password)@mongo-mongodb.logging.svc.cluster.local/graylog \
		--set graylog.elasticsearch.hosts=http://elastic-elasticsearch-master.logging.svc.cluster.local:9200 \
		--set graylog.elasticsearch.version=7 \
		--set graylog.persistence.size="10Gi" \
    	-f values_graylog.yaml

	# Create Ingress
		kubectl apply -f ingress-graylog.yaml -n logging
	
	# waiting 20 secondes before install oidc plugin
	#sleep 20

	# install oidc plugin on prometheus route
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/logging.graylog.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=graylog' \
	--data 'config.client_secret=25acbd19-afe0-49d7-81b4-580010df28c7' \
	--data 'config.discovery=http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"


delete:
	# Deleting all components for graylog
	helm uninstall graylog -n logging 