.PHONY: build deploy delete 


build:
	# Building Kong Ingress Controller
	@echo | safescale cluster helm $(TARGET_CLUSTER) repo add kong https://charts.konghq.com
	@echo | safescale cluster helm $(TARGET_CLUSTER) repo update
	
	
deploy:
	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(KONG_VERSION):;s:VALUE2:$(FLOATING_IP):" values.tmpl > values.yaml

	# Deploy Kong Ingress Controller
	@echo | safescale cluster helm $(TARGET_CLUSTER) install kong kong/kong --version=$(KONG_CHART_VERSION) --create-namespace --namespace=kong -f values.yaml

	# Add Prometheus plugin
	@echo | safescale cluster kubectl $(TARGET_CLUSTER) apply -f kong-prometheus-plugin/kong-prometheus-plugin.yaml

	# Delete values.yaml
	@ rm values.yaml

delete:
	# Deleting Kong Ingress Controller
	@echo | safescale cluster helm $(TARGET_CLUSTER) delete kong -n kong



	
