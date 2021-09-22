.PHONY: build deploy delete 

build:
	# Build all components for Graylog
	helm repo add kongz https://charts.kong-z.com
	helm repo update
	
deploy:
	# Deploy all components for Graylog

	@sed "s:VALUE1:$(GRAYLOG_VERSION):" values_graylog.tmpl > values_graylog.yaml

	helm install graylog --namespace logging --wait kongz/graylog --version $(GRAYLOG_CHART_VERSION) \
	--set tags.install-mongodb=false \
	--set tags.install-elasticsearch=false \
	--set graylog.mongodb.uri=mongodb://graylog:graylog_World_Cereal_2021@mongo-mongodb.logging.svc.cluster.local/graylog \
	--set graylog.elasticsearch.hosts=http://elastic-elasticsearch-master.logging.svc.cluster.local:9200 \
	--set graylog.elasticsearch.version=7 \
	--set graylog.persistence.size="10Gi" \
    -f values_graylog.yaml

	# Create Ingress
		kubectl apply -f ingress-graylog.yaml -n logging

delete:
	# Deleting all components for graylog
	helm uninstall graylog -n logging 



