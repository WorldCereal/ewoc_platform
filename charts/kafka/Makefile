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
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic preprocessing.logs --partitions=6 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic keycloak.logs --partitions=1 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic system.logs --partitions=6 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"


delete:
	# Delete kafka component
	helm uninstall kafka -n logging
