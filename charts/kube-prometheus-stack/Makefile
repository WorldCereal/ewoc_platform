.PHONY: build deploy delete

build:
	# Build Kube Prometheus Stack
	
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

deploy:
	# Deploy Kube Prometheus Stack
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Generate values.yaml
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:GRAFANA_CS:$(GRAFANA_CS):g" values.tmpl > values.yaml

	# install kube prometheus stack
	helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack  --version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --create-namespace --namespace=monitoring  -f values.yaml

	# Genarate values.yaml from template file
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:PROMETHEUS_CS:$(PROMETHEUS_CS):;s:GRAFANA_CS:$(GRAFANA_CS):g" ingress.tmpl > ingress.yaml

    # create ingress
	@kubectl apply -f ingress.yaml -n monitoring

delete:
	# Delete Kube Prometheus Stack
	helm uninstall kube-prometheus-stack -n monitoring
	@kubectl delete ingress -n monitoring grafana prometheus