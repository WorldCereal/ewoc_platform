.PHONY: build deploy delete

build:
	
	# Build Cert Manager component
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	
deploy:

	# Deploy Cert Manager component

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@helm upgrade --install cert-manager jetstack/cert-manager \
		--namespace cert-manager \
		--create-namespace \
		--version v$(CERT_MANAGER_CHART_VERSION) \
		--set installCRDs=true \
		--values values.yaml


	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(CERT_MANAGER_MAIL):" issuer.tmpl > issuer.yaml

	@kubectl apply -f issuer.yaml

delete:
	# Delete Cert-manager component
	@helm uninstall cert-manager -n cert-manager
