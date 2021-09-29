.PHONY: build deploy delete

build:
	
	# Build Keycloack component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
	
deploy:

	# Deploy Keycloack component

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)


	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KEYCLOAK_VERSION):;s:VALUE2:$(HOSTNAME):" values.tmpl > values.yaml

	helm install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml
	

delete:
	# Dump database before remove Keycloak instance
	cd backup & make dump

	# Delete Keycloack component
	helm uninstall keycloak -n keycloak
