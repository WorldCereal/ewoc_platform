.PHONY: build deploy delete 

build:
	# Building Kong Ingress Controller
	@safescale cluster helm $(TARGET_CLUSTER) repo add bitnami https://charts.bitnami.com/bitnami
	@safescale cluster helm $(TARGET_CLUSTER) repo update
	
	
deploy:
	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KEYCLOAK_VERSION):;s:VALUE2:$(HOSTNAME):" values.tmpl > values.yaml

	# Deploy Kong Ingress Controller
	@safescale cluster helm $(TARGET_CLUSTER) install keycloak bitnami/keycloak --version=$(KEYCLOAK_CHART_VERSION) --create-namespace --namespace=keycloak -f values.yaml

	# Delete values.yaml
	@ rm values.yaml

delete:
	# Deleting Kong Ingress Controller
	@safescale cluster helm $(TARGET_CLUSTER) delete kong -n kong


