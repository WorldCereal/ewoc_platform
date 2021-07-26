.PHONY: build deploy delete 

build:
	
	echo "Building Keycloack on cluster:$(TARGET_CLUSTER)" 
	safescale cluster helm $(TARGET_CLUSTER) repo add bitnami https://charts.bitnami.com/bitnami
	safescale cluster helm $(TARGET_CLUSTER) repo update
	
	
deploy:

	echo "Deploy Keycloack on cluster:$(TARGET_CLUSTER)" 

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KEYCLOAK_VERSION):;s:VALUE2:$(HOSTNAME):" values.tmpl > values.yaml

	#TODO: Import Worldcereal realm.

	safescale cluster helm $(TARGET_CLUSTER) install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml

delete:
	echo "Delete Keycloack on cluster:$(TARGET_CLUSTER)" 
	safescale cluster helm $(TARGET_CLUSTER) uninstall keycloak -n keycloak


