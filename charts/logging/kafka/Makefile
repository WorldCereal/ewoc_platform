.PHONY: build deploy delete 

build:
	
	# Build Kafka component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
deploy:

	# Deploy Kafka component
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Create namespace & secrets
	#kubectl apply -f init/init-deployment.yaml

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KAFKA_VERSION):" values.tmpl > values.yaml

	# TODO scale up pvc size for prod env
	helm install kafka bitnami/kafka --version=$(KAFKA_CHART_VERSION) --wait --namespace=logging  -f values.yaml

	# Create Topics Kafka
	# retention 7 jours (1000*60*60*24*7) 
	kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic preprocessing.logs --partitions=3 --replication-factor=3 --config cleanup.policy=delete --config retention.ms=604800000 --config retention.bytes="-1"
	
	# kubectl exec -n logging kafka-0 -- kafka-console-producer.sh --topic preprocessing.logs --bootstrap-server kafka.logging.svc.cluster.local:9092
    # kubectl exec -n logging kafka-0 -c kafka -- kafka-console-consumer.sh --topic preprocessing.logs --from-beginning --bootstrap-server kafka.logging.svc.cluster.local:9092

delete:
	# Delete Fluentbit component
	helm uninstall kafka -n logging


