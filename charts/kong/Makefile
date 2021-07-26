.PHONY: build deploy delete 


build:
	
	echo "Building Kong Ingress Controller on cluster:$(TARGET_CLUSTER)" 
	safescale cluster helm $(TARGET_CLUSTER) repo add kong https://charts.konghq.com
	safescale cluster helm $(TARGET_CLUSTER) repo update
	
	
deploy:

	echo "Deploy Kong Ingress Controller on cluster:$(TARGET_CLUSTER)" 

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KONG_VERSION):;s:VALUE2:$(FLOATING_IP):" values.tmpl > values.yaml

	# Deploy Kong Ingress Controller
	safescale cluster helm $(TARGET_CLUSTER) install kong kong/kong --version=$(KONG_CHART_VERSION) --create-namespace --namespace=kong -f values.yaml

	# Add Prometheus plugin
	safescale cluster kubectl $(TARGET_CLUSTER) apply -f kong-prometheus-plugin/kong-prometheus-plugin.yaml


delete:

	echo "Delete Kong Ingress Controller on cluster:$(TARGET_CLUSTER)" 
	safescale cluster helm $(TARGET_CLUSTER) uninstall kong -n kong



	
