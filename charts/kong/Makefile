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
	@sed "s:VALUE1:$(KONG_VERSION):" values.tmpl > values.yaml

	# Create namespace & secrets
	kubectl apply -f init/init-deployment.yaml

	# Deploy a Postgres DB for Kong
	@helm install kong-postgresql bitnami/postgresql --version=$(POSTGRESQL_CHART_VERSION) --values postgresql/values.yaml -n kong

	# Deploy Kong Gateway & Kong Ingress Controller
	helm install kong kong/kong --version=$(KONG_CHART_VERSION) --namespace=kong -f values.yaml

	# Add Prometheus plugin
	kubectl  apply -f plugins/kong-prometheus-plugin.yaml

	# Deploy a tool pod for Kong
	kubectl apply -f tools/pod.yaml

delete:

	# Deleting all components for Kong
	helm  uninstall kong -n kong
	helm uninstall kong-postgresql -n kong
	kubectl delete -f tools/pod.yaml
	kubectl delete -f plugins/kong-prometheus-plugin.yaml
