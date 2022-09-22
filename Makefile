.PHONY: build certmgr pgsql kong deploy delete 


build:
	# Build all components for Kong
	helm repo add jetstack https://charts.jetstack.io
	helm repo add kong https://charts.konghq.com
	helm repo add bitnami https://charts.bitnami.com/bitnami
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

	# Delete ingress
# 	kubectl delete -n keycloak ingress keycloak
	# Delete Keycloack component
# 	helm uninstall keycloak -n keycloak

	# Deleting all components for Kong
	kubectl delete -f charts/kong/plugins/kong-prometheus-plugin.yaml
	helm uninstall kong -n kong
	helm uninstall pgsqlha -n sysdb
	kubectl delete -n sysdb pvc data-pgsqlha-postgresql-0 data-pgsqlha-postgresql-1 data-pgsqlha-postgresql-2
# 	helm uninstall cert-manager -n cert-manager


