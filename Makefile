.PHONY: init certmgr pgsql kong keycloak monitoring graylog mongo elasticsearch kafka fluentbit deploy delete  


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
		--namespace=cert-manager --create-namespace \
		--version v$(CERT_MANAGER_CHART_VERSION) \
		--set installCRDs=true \
		--values charts/cert-manager/values.yaml


	# Genarate values.yaml from template file
	sed "s:VALUE1:$(CERT_MANAGER_MAIL):" charts/cert-manager/issuer.tmpl | kubectl apply -f-

pgsql:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	# @sed "s:VALUE_PGTAG:$(POSTGRESQL_VERSION):" charts/postgresql-ha/values.tmpl > postgresql/values.yaml
	helm upgrade --install pgsqlha bitnami/postgresql-ha --namespace=sysdb \
				--version=$(POSTGRESQL_CHART_VERSION) --values=charts/postgresql-ha/values.yaml


kong:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	@sed "s:CS_REGISTRY:$(CS_REGISTRY): ; s:VALUE_KONGTAG:$(KONG_VERSION):" charts/kong/values.tmpl >kong-values.yaml
	helm upgrade --install kong kong/kong --namespace=kong \
				--version=$(KONG_CHART_VERSION) --values=kong-values.yaml

	# Add Prometheus plugin
	kubectl apply -f charts/kong/plugins/kong-prometheus-plugin.yaml

keycloak:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):g" charts/keycloak/WC-realm.tmpl > WC-realm.json
	@kubectl get configmap -n keycloak realm-config || kubectl create configmap realm-config --from-file=WC-realm.json -n keycloak
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/keycloak/values.tmpl > keycloak-values.yaml
	helm upgrade --install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) \
    --namespace=keycloak -f keycloak-values.yaml --set=installCRDs=true
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/keycloak/ingress.tmpl > keycloak-ingress.yaml
	kubectl apply -f keycloak-ingress.yaml -n keycloak

monitoring:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:GRAFANA_CS:$(GRAFANA_CS):;s:PG_PASS:$(shell kubectl get secret -n monitoring system-db -o=jsonpath={.data.postgresql-password} | base64 -d):g" charts/kube-prometheus-stack/values.tmpl > monitoring-values.yaml
	helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack  \
	--version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) -n monitoring  -f monitoring-values.yaml

	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:PROMETHEUS_CS:$(PROMETHEUS_CS):;s:GRAFANA_CS:$(GRAFANA_CS):g" charts/kube-prometheus-stack/ingress.tmpl > monitoring-ingress.yaml
	@kubectl apply -f monitoring-ingress.yaml -n monitoring

mongo:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install mongo bitnami/mongodb --namespace=logging \
				--version=$(MONGO_CHART_VERSION) --values=charts/mongo/values_mongo.yaml
	kubectl rollout status -n logging statefulset mongo-mongodb

elasticsearch:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	#helm upgrade --install elastic bitnami/elasticsearch --version=$(ELASTIC_CHART_VERSION) -n logging -f charts/elasticsearch/values_elastic.yaml
	helm upgrade --install elastic elastic/elasticsearch --namespace=logging \
				--version=$(ELASTIC_CHART_VERSION) --values=charts/elasticsearch/values_elastic.yaml
	kubectl rollout status -n logging statefulset ewoc-elastic-master

graylog:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }

	@kubectl get configmap -n logging graylog-contentpacks \
		|| kubectl create configmap graylog-contentpacks --namespace=logging --from-file=charts/graylog/contentpacks.json
	
	@sed "s:VALUE_GRAYLOG_VERSION:$(GRAYLOG_VERSION):" charts/graylog/values-graylog.tmpl >graylog-values.yaml
	helm upgrade --install graylog kongz/graylog --namespace=logging \
				--version $(GRAYLOG_CHART_VERSION) --values=values-graylog.yaml

	# Create Ingress
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:GRAYLOG_CS:$(GRAYLOG_CS):" charts/graylog/ingress-graylog.tmpl | kubectl apply -n logging -f-

kafka:
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install kafka -n logging bitnami/kafka --version $(KAFKA_CHART_VERSION) -f charts/kafka/values-kafka.yaml

fluentbit: 
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }
	helm upgrade --install fluent-bit fluent/fluent-bit --namespace=logging \
				--version $(FLUENTBIT_CHART_VERSION) --values=charts/fluentbit/values-fluentbit.yaml

deploy:
	# Deploy all components for Kong
	@test -n "$(CLUSTER_ENV_LOADED)" || { echo 'The env variables should be source before run this script' && exit 1; }

	certmgr

	### Postgres DB
	pgsql

	### Kong Gateway & Kong Ingress Controller
	kong

# 	@sed "s:CS_REGISTRY:$(CS_REGISTRY): ; s:VALUE_KONGTAG:$(KONG_VERSION):" charts/kong/values.tmpl >kong-values.yaml
# 	helm upgrade --install kong kong/kong --namespace=kong \
# 				--version=$(KONG_CHART_VERSION) --values=kong-values.yaml

	# Add Prometheus plugin
# 	kubectl apply -f charts/kong/plugins/kong-prometheus-plugin.yaml

	### Keycloak

	# Generating Keycloak preset realm configuration
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):g" charts/keycloak/WC-realm.tmpl > WC-realm.json
	# Create Keycloak realm configuration configmap
	@kubectl get configmap -n keycloak realm-config || kubectl create configmap realm-config --from-file=WC-realm.json -n keycloak

	# Generate values.yaml from template file
	@sed "s:VALUE_KCVERS:$(KEYCLOAK_VERSION):" charts/keycloak/values.tmpl > keycloak-values.yaml
	helm upgrade --install keycloak bitnami/keycloak --namespace=keycloak \
				--version=$(KEYCLOAK_CHART_VERSION) --values=values.yaml --set=installCRDs=true

	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" charts/keycloak/ingress.tmpl | kubectl apply -f-


delete:

	# Deleting logging stack
	helm uninstall -n logging fluent-bit
	helm uninstall -n logging graylog
	kubectl delete -n logging cm graylog-contentpacks
	helm uninstall -n logging elastic
	helm uninstall -n logging mongo
	kubectl delete -n logging pvc --all

	# # Delete ingress
	# kubectl delete -n keycloak ingress keycloak
	kubectl delete -n sysdb pvc --all
	helm uninstall cert-manager -n cert-manager

	# Deleting all components for Kong
	kubectl delete -f charts/kong/plugins/kong-prometheus-plugin.yaml
	helm uninstall kong -n kong
	helm uninstall pgsqlha -n sysdb
	kubectl delete -n sysdb pvc data-pgsqlha-postgresql-0 data-pgsqlha-postgresql-1 data-pgsqlha-postgresql-2
# 	helm uninstall cert-manager -n cert-manager


