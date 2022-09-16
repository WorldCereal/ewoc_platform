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

	# Deploy Mongo
	helm upgrade --install mongo bitnami/mongodb  --namespace=logging --version=$(MONGO_CHART_VERSION) -f values_mongo.yaml

delete:
	helm uninstall mongo -n logging



