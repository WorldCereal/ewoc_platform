.PHONY: build deploy delete

build:
	# Build Kube Prometheus Stack
	
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

deploy:
	# Deploy Kube Prometheus Stack

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" values.tmpl > values.yaml

	
	helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack  --version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --create-namespace --namespace=monitoring  -f values.yaml

delete:
	# Delete Kube Prometheus Stack

	helm uninstall kube-prometheus-stack -n monitoring

