.PHONY: build deploy delete

build:
	
	@echo "Build Kube-Prometheus-Stack on cluster:$(TARGET_CLUSTER)" 
	@echo | safescale cluster helm $(TARGET_CLUSTER) repo add prometheus-community https://prometheus-community.github.io/helm-charts
	@echo | safescale cluster helm $(TARGET_CLUSTER) repo update

deploy:

	@echo "Deploy Kube-Prometheus-Stack on cluster:$(TARGET_CLUSTER)" 
	
	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" values.tmpl > values.yaml

	#TODO: Post routes on kong gateway
	
	@echo | safescale cluster helm $(TARGET_CLUSTER) install kube-prometheus-stack prometheus-community/kube-prometheus-stack  --version=$(KUBE_PROMETHEUS_STACK_CHART_VERSION) --create-namespace --namespace=monitoring  -f values.yaml
	

delete:

	@echo "Delete Kube-Prometheus-Stack on cluster:$(TARGET_CLUSTER)" 
	@echo | safescale cluster helm $(TARGET_CLUSTER) uninstall kube-prometheus-stack -n monitoring
