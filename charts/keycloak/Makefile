.PHONY: build deploy delete

#password= $(shell kubectl get secret -n sysdb system-db -o=jsonpath={.data.postgresql-password} | base64 -d)

build:
	
	# Build Keycloack component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update

deploy:

	# Deploy Keycloack component

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Generating Keycloak preset realm configuration
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):g" WC-realm.tmpl > WC-realm.json

	# Create Keycloak realm configuration configmap
	@kubectl get configmap -n keycloak realm-config || kubectl create configmap realm-config --from-file=WC-realm.json -n keycloak

	# Generate values.yaml from template file
#	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:PG_PASS:$(password):" values.tmpl > values.yaml
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" values.tmpl > values.yaml


	helm upgrade --install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml --set=installCRDs=true
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" ingress.tmpl > ingress.yaml

	kubectl apply -f ingress.yaml -n keycloak

delete:
	# Delete Keycloack component
	helm uninstall keycloak -n keycloak

	# Delete configmap
	kubectl delete -n keycloak configmap realm-config

	# Delete ingress
	kubectl delete -n keycloak ingress keycloak
