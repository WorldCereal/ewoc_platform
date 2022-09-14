.PHONY: build deploy delete 


build:
	# Build all components for Kong
	helm repo add kong https://charts.konghq.com
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update

deploy:
	# Deploy all components for Kong
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	# Genarate values.yaml from template file
	@sed "s:VALUE_PGTAG:$(POSTGRESQL_VERSION):" postgresql/values.tmpl > postgresql/values.yaml
	#@sed "s:VALUE_HOSTNAME:$(HOSTNAME):g" plugins/kong-oidc.tmpl > plugins/kong-oidc.yaml
	@sed "s:VALUE_KONGTAG:$(KONG_VERSION):" values.tmpl > values.yaml

	# Create namespace
	@kubectl get ns kong || kubectl create namespace kong

	# Deploy a Postgres DB for Kong
	helm upgrade --install kong-postgresql bitnami/postgresql --namespace=kong --version=$(POSTGRESQL_CHART_VERSION) --values=postgresql/values.yaml

	# Deploy Kong Gateway & Kong Ingress Controller
	helm upgrade --install kong kong/kong --namespace=kong --version=$(KONG_CHART_VERSION) --values=values.yaml

	# Add Prometheus plugin
	#kubectl apply -f plugins/kong-prometheus-plugin.yaml
	#kubectl apply -f plugins/kong-oidc.yaml

	# Deploy a tool pod for Kong
	#kubectl apply -f tools/pod.yaml

delete:

	# Deleting all components for Kong
	helm uninstall kong -n kong
	helm uninstall kong-postgresql -n kong
	kubectl delete -f tools/pod.yaml
	kubectl delete -f plugins/kong-prometheus-plugin.yaml
