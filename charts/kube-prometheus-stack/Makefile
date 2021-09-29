.PHONY: build deploy delete 

build:
	# Build Kube Prometheus Stack
	
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

deploy:
	# Deploy Kube Prometheus Stack

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" values.tmpl > values.yaml

	# install kube prometheus stack
	helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack  --version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --create-namespace --namespace=monitoring  -f values.yaml

	# waiting 20 secondes before install oidc plugin
	sleep 20

	# install oidc plugin on prometheus route
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=prometheus' \
	--data 'config.introspection_endpoint=http://auth.$(HOSTNAME)/auth/realms/worldcereal/protocol/openid-connect/token/introspect' \
	--data 'config.client_secret=f59de7a5-caf5-474b-ae28-3ca6e29462a7' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

	# install oidc plugin on grafana route
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-grafana.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=grafana' \
	--data 'config.client_secret=f83a7e0e-8603-4fa7-b71f-c1c997591c3e' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"


delete:
	# Delete Kube Prometheus Stack

	helm uninstall kube-prometheus-stack -n monitoring
