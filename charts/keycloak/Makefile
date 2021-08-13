.PHONY: build deploy delete 

build:
	
	# Build Keycloack component
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	
	
deploy:

	# Deploy Keycloack component

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KEYCLOAK_VERSION):;s:VALUE2:$(HOSTNAME):" values.tmpl > values.yaml

	#TODO: Import Worldcereal realm.

	helm install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml
	kubectl apply -f keycloak-ingress.yaml

delete:
	# Delete Keycloack component
	helm uninstall keycloak -n keycloak
	kubectl delete -f keycloak-ingress.yaml


