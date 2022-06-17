.PHONY: build deploy delete create_topic

build:
	
	# Build Kafka component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
deploy:

	# Deploy Kafka component
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Install Kafka
	helm install kafka bitnami/kafka --namespace=logging  -f values.yaml


create_topic:
	# Create Topics Kafka
	# retention 1 day (1000*60*60*24*1) 
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic preprocessing.logs --partitions=1 --replication-factor=2 --config cleanup.policy=delete --config retention.ms=86400000 --config retention.bytes="-1"
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic keycloak.logs --partitions=1 --replication-factor=2 --config cleanup.policy=delete --config retention.ms=86400000 --config retention.bytes="-1"


delete:
	# Delete kafka component
	helm uninstall kafka -n logging
