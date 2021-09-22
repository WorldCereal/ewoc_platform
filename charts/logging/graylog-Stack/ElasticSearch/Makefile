.PHONY: build deploy delete 

build:
	# Build all components for Graylog

	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
deploy:
	# Deploy all components for Graylog

	@sed "s:VALUE1:$(ELASTIC_VERSION):" values_elastic.tmpl > values_elastic.yaml
	helm install elastic bitnami/elasticsearch --version=$(ELK_CHART_VERSION) --wait --namespace=logging -f values_elastic.yaml

delete:
	# Deleting all components for Graylog
	helm uninstall elastic -n logging



