.PHONY: build deploy delete 

build:
	# Build all components for Graylog

	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
deploy:
	# Deploy all components for Graylog

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(MONGO_VERSION):" values_mongo.tmpl > values_mongo.yaml

	# Deploy Mongo
	helm install mongo bitnami/mongodb --version=$(MONGO_CHART_VERSION) --wait --namespace=logging -f values_mongo.yaml

delete:

	# Deleting all components for graylog
	helm uninstall mongo -n logging



