.PHONY: build delete deploy_operator deploy_topics

build:
	
	# Build Kafka component
	helm repo add strimzi https://strimzi.io/charts/
	helm repo update

deploy_operator: 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	helm install operatorkafka strimzi/strimzi-kafka-operator -f values_operator.yaml --skip-crds=false -n logging
	kubectl apply -f kafka_values.yaml -n logging

deploy_topics:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	kubectl apply -f Topics/ -n logging

delete:
	kubectl delete kafkatopics.kafka.strimzi.io -n logging keycloak.logs preprocessing.logs
	kubectl delete -n logging  kafka kafka-cluster
	helm uninstall operatorkafka -n logging