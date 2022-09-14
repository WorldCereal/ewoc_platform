.PHONY: build deploy delete

build:
	
	# Build Keycloack component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
	
deploy:

	# Deploy Keycloack component

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Genarate values.yaml from template file
	@sed "s:VALUE_KCVERS:$(KEYCLOAK_VERSION):" values.tmpl > values.yaml

	helm upgrade --install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml --set=installCRDs=true
	
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):" ingress.tmpl > ingress.yaml

	kubectl apply -f ingress.yaml -n keycloak

delete:
	# Delete Keycloack component
	helm uninstall keycloak -n keycloak

	# Delete ingress
	kubectl delete -n keycloak ingress keycloak
