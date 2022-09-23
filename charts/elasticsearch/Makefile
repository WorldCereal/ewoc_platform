.PHONY: build deploy delete 

build:
	# Build all components for Graylog
	helm repo add bitnami https://charts.bitnami.com/bitnami	
	helm repo update
	
deploy:
	# Deploy all components for Graylog
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Create namespace
	@kubectl get ns logging || kubectl create namespace logging

	@sed "s:VALUE1:$(ELASTIC_VERSION):" values_elastic.tmpl > values_elastic.yaml
	
	helm upgrade --install elastic bitnami/elasticsearch --version=$(ELASTIC_CHART_VERSION) --namespace=logging -f values_elastic.yaml

delete:
	# Deleting all components for Graylog
	helm uninstall elastic -n logging

