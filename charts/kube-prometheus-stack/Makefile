.PHONY: build deploy delete

build:
	# Build Kube Prometheus Stack
	
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

deploy:
	# Deploy Kube Prometheus Stack
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# install kube prometheus stack
	helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack  --version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --create-namespace --namespace=monitoring  -f values.yaml

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):;s:VALUE2:$(PROMETHEUS_CS):;s:VALUE3:$(GRAFANA_CS):g" ingress.tmpl > ingress.yaml

    # create ingress
	@kubectl apply -f ingress.yaml -n monitoring

delete:
	# Delete Kube Prometheus Stack
	helm uninstall kube-prometheus-stack -n monitoring
	@kubectl delete ingress -n monitoring grafana prometheus