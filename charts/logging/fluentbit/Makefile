.PHONY: build deploy delete 

build:
	
	# Build Fluentbit component
	helm repo add fluent https://fluent.github.io/helm-charts
	helm repo update
	
deploy:

	# Deploy Fluentbit component

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(FLUENTBIT_VERSION):" values.tmpl > values.yaml

	helm install fluent-bit fluent/fluent-bit --version=$(FLUENTBIT_CHART_VERSION) -n logging -f values.yaml

delete:
	# Delete Fluentbit component
	helm uninstall fluent-bit -n logging