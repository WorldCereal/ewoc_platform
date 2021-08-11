.PHONY: build deploy delete 


build:
	# Build all components for Kong
	helm repo add kong https://charts.konghq.com
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
	
deploy:
	# Deploy all components for Kong
	
	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KONG_VERSION):;s:VALUE2:$(FLOATING_IP):" values.tmpl > values.yaml

	# Create namespace & secrets
	kubectl apply -f init/init-deployment.yaml

	# Deploy a Postgres DB for Kong
	@helm install kong-postgresql bitnami/postgresql --version=$(POSTGRESQL_CHART_VERSION) --values postgresql/values.yaml -n kong

	# Deploy Kong Gateway & Kong Ingress Controller
	helm install kong kong/kong --version=$(KONG_CHART_VERSION) --namespace=kong -f values.yaml

	# Add Prometheus plugin
	#kubectl  apply -f kong-prometheus-plugin/kong-prometheus-plugin.yaml


delete:

	# Deleting all components for Kong
	helm  uninstall kong -n kong
	helm delete kong-postgresql -n kong

