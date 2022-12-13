.PHONY: init certmgr pgsql kong keycloak monitoring thanos mongo elasticsearch graylog graylog-config kafka fluentbit vdm rdm deploy delete-logging delete


init:
	# Build all components for Kong
	helm repo add jetstack https://charts.jetstack.io
	helm repo add kong https://charts.konghq.com
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add elastic https://helm.elastic.co
	helm repo add kongz https://charts.kong-z.com
	helm repo add fluent https://fluent.github.io/helm-charts
	helm repo update
	chmod 755 sys-init.sh && ./sys-init.sh

certmgr:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install cert-manager jetstack/cert-manager \
		--namespace=cert-manager --create-namespace --set installCRDs=true \
		--version v$(CERT_MANAGER_CHART_VERSION) --values charts/cert-manager/values.yaml

	# Genarate values.yaml from template file
	sed "s:VALUE1:$(CERT_MANAGER_MAIL):" charts/cert-manager/issuer.tmpl | kubectl apply -f-

pgsql:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	# @sed "s:VALUE_PGTAG:$(POSTGRESQL_VERSION):" charts/postgresql-ha/values.tmpl > postgresql/values.yaml
	helm upgrade --install pgsqlha bitnami/postgresql-ha --namespace=sysdb \
				--version=$(POSTGRESQL_CHART_VERSION) --values=charts/postgresql-ha/values.yaml
	kubectl rollout status -n sysdb deployment pgsqlha-pgpool
	kubectl rollout status -n sysdb statefulset pgsqlha-postgresql

kong:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	@sed "s:CS_REGISTRY:$(CS_REGISTRY): ; s:VALUE_KONGTAG:$(KONG_VERSION):" charts/kong/values.tmpl >kong-values.yaml
	helm upgrade --install kong kong/kong --namespace=kong \
				--version=$(KONG_CHART_VERSION) --values=kong-values.yaml
	kubectl rollout status -n sysdb daemonset kong-kong

	# Add Prometheus plugin
	kubectl apply -f charts/kong/plugins/kong-prometheus-plugin.yaml

keycloak:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Generating Keycloak preset realm configuration
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):g; s:GRAYLOG_CS:$(GRAYLOG_CS):; s:PROMETHEUS_CS:$(PROMETHEUS_CS):; s:GRAFANA_CS:$(GRAFANA_CS):; s:WCT_CS:$(WCT_CS):; s:RDM_API_CS:$(RDM_API_CS):; s:RDM_CS:$(RDM_CS):; s:VDM_CS:$(VDM_CS):; s:VDM_API_CS:$(VDM_API_CS):; s:API_CS:$(API_CS):;" charts/keycloak/WC-realm.tmpl > WC-realm.json
	# Create Keycloak realm configuration configmap
	@kubectl get configmap -n keycloak realm-config || kubectl create configmap realm-config --from-file=WC-realm.json -n keycloak
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/keycloak/values.tmpl > keycloak-values.yaml
	helm upgrade --install keycloak bitnami/keycloak --namespace=keycloak --set=installCRDs=true \
    			--version=$(KEYCLOAK_CHART_VERSION) --values=keycloak-values.yaml
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/keycloak/ingress.tmpl | kubectl apply --namespace=keycloak -f-
	kubectl rollout status -n keycloak statefulset keycloak

thanos:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	helm upgrade --install thanos bitnami/thanos --create-namespace --namespace=monitoring  --values=charts/thanos/values.yaml


monitoring:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:GRAFANA_CS:$(GRAFANA_CS):;s:PG_PASS:$(shell kubectl get secret -n monitoring system-db -o=jsonpath={.data.postgresql-password} | base64 -d):g" charts/kube-prometheus-stack/values.tmpl > monitoring-values.yaml
	helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack  \
				--version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --namespace=monitoring --values=monitoring-values.yaml

	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:PROMETHEUS_CS:$(PROMETHEUS_CS):;s:GRAFANA_CS:$(GRAFANA_CS):g" charts/kube-prometheus-stack/ingress.tmpl > monitoring-ingress.yaml
	@kubectl apply -f monitoring-ingress.yaml -n monitoring

	kubectl rollout status -n monitoring statefulset prometheus-kube-prometheus-stack-prometheus
	kubectl rollout status -n monitoring deployment kube-prometheus-stack-grafana

mongo:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install mongo bitnami/mongodb --namespace=logging \
				--version=$(MONGO_CHART_VERSION) --values=charts/mongo/values-mongo.yaml
	kubectl rollout status -n logging statefulset mongo-mongodb

elasticsearch:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	#helm upgrade --install elastic bitnami/elasticsearch --version=$(ELASTIC_CHART_VERSION) -n logging -f charts/elasticsearch/values-elastic.yaml
	helm upgrade --install elastic elastic/elasticsearch --namespace=logging \
				--version=$(ELASTIC_CHART_VERSION) --values=charts/elasticsearch/values-elastic.yaml
	kubectl rollout status -n logging statefulset ewoc-elastic-master

# kafka:
# 	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
# 	helm upgrade --install kafka bitnami/kafka --namespace=logging \
# 				--version $(KAFKA_CHART_VERSION) --values=charts/kafka/values-kafka.yaml

# 	kubectl rollout status -n logging statefulset kafka

# 	# Create Topics Kafka 
# 	# kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic preprocessing.logs --partitions=6 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"
# 	# kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic keycloak.logs --partitions=1 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"
# 	# kubectl exec -n logging kafka-0 -c kafka -- kafka-topics.sh --bootstrap-server kafka.logging.svc.cluster.local:9092 --create --topic system.logs --partitions=6 --replication-factor=1 --config cleanup.policy=delete --config retention.ms=3600000 --config retention.bytes="-1"

graylog:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }

	@sed "s:VALUE_GRAYLOG_VERSION:$(GRAYLOG_VERSION):; s:VALUE_KUBECTL_VERSION:$(GRAYLOG_KUBECTL_VERSION):; s:VALUE_HOSTNAME:$(HOSTNAME):g" charts/graylog/values-graylog.tmpl >values-graylog.yaml
	helm upgrade --install graylog kongz/graylog --namespace=logging \
				--version $(GRAYLOG_CHART_VERSION) --values=values-graylog.yaml

	# Create Ingress
	#@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:GRAYLOG_CS:$(GRAYLOG_CS):" charts/graylog/ingress-graylog.tmpl | kubectl apply -n logging -f-

	kubectl rollout status -n logging statefulset graylog

graylog-config:
	# cleaning
	@kubectl get job -n logging graylog-config && kubectl delete --namespace=logging job.batch/graylog-config && sleep 5 || echo

	kubectl create configmap graylog-config --namespace=logging --from-file=charts/graylog/config.py --dry-run=client -oyaml | kubectl apply -f-
	kubectl apply -f charts/graylog/config-job.yaml

fluentbit: 
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install fluent-bit fluent/fluent-bit --namespace=logging \
				--version $(FLUENTBIT_CHART_VERSION) --values=charts/fluentbit/values-fluentbit.yaml

	kubectl rollout status -n logging daemonset fluent-bit

rdm:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Ingress
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:RDM_CS:$(RDM_CS):;s:RDM_API_CS:$(RDM_API_CS):g" charts/rdm/ingress.tmpl > rdm-ingress.yaml
	@kubectl apply -f rdm-ingress.yaml -n rdm 

vdm:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Ingress
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:VDM_CS:$(VDM_CS):;s:VDM_API_CS:$(VDM_API_CS):g" charts/vdm/ingress.tmpl > vdm-ingress.yaml
	@kubectl apply -f vdm-ingress.yaml -n vdm 

wctiler: 
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }

	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:WCT_CS:$(WCT_CS):g" charts/wctiler/ingress.tmpl > ingress-wctiler.yaml

	# Create pgsql connexion conf
	@sed "s:HOST:$(WCT_HOST_DB):;s:PORT:$(WCT_DB_PORT):;s:DBNAME:$(WCT_DB_NAME):;s:USER:$(WCT_DB_USER):;s:PASSWORD:$(WCT_DB_PASSWORD):" charts/wctiler/chart/config/mapfiles/postgres_connection.inc.map.tmpl > charts/wctiler/chart/config/mapfiles/postgres_connection.inc.map.sample

	# Set WMS service URL 
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/wctiler/chart/config/worldcereal_status.tmpl > charts/wctiler/chart/config/worldcereal_status.html

	# Set Values.yaml
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:CS_REGISTRY:$(CS_REGISTRY):;" charts/wctiler/chart/values.tmpl > values-wctiler.yaml

	# Install chart
	@helm upgrade --install mapproxy  charts/wctiler/chart/ --namespace=wctiler --values values-wctiler.yaml --set-file mapserver.mapfiles.postgresConnection=charts/wctiler/chart/config/mapfiles/postgres_connection.inc.map.sample

	# create ingress for WCTiler
	@kubectl apply -f ingress-wctiler.yaml -n wctiler

deploy:
	# Deploy all components for Kong
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }

	certmgr

	### Postgres DB
	pgsql

	### Kong Gateway & Kong Ingress Controller
	kong

	### Keycloak
	keycloak

	### Logging stack
	mongo
	elasticsearch
	graylog
	fluentbit


delete-logging:
	# Deleting logging stack
	helm uninstall -n logging fluent-bit
	helm uninstall -n logging graylog
	helm uninstall -n logging elastic
	helm uninstall -n logging mongo
	kubectl delete -n logging cm --all
	kubectl delete -n logging pvc --all


delete:

	# Deleting logging stack
	helm uninstall -n logging fluent-bit
	helm uninstall -n logging graylog
	kubectl delete -n logging cm graylog-contentpacks
	helm uninstall -n logging elastic
	helm uninstall -n logging mongo
	kubectl delete -n logging pvc --all

	# Delete ingress
	kubectl delete -n keycloak ingress keycloak
	# Delete Keycloack component
	helm uninstall -n keycloak keycloak

	# Deleting all components for Kong
	kubectl delete -f charts/kong/plugins/kong-prometheus-plugin.yaml
	helm uninstall -n kong kong
	helm uninstall -n sysdb pgsqlha
	kubectl delete -n sysdb pvc --all
	helm uninstall -n cert-manager cert-manager


