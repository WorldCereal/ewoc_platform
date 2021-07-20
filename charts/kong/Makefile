.PHONY: build deploy delete 


build:
	# Building Kong Ingress Controller
	@helm repo add kong https://charts.konghq.com
	@helm repo update
	
	
deploy:
	# add plugins
	@kubectl apply -f kong-prometheus-plugin/kong-prometheus-plugin.yaml
	@helm install kong kong/kong --create-namespace --namespace=kong -f values.yaml

delete:
	@helm delete kong -n kong
