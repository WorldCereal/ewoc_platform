.PHONY: build deploy delete

build:
	# Build helm repo for  WCTiller 
	@docker build  helm/ -t hfjcmwgl.gra5.container-registry.ovh.net/worldcereal/wctiller:$(WCT_VERSION) 

deploy:
	# Deploy WCTiller 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	@sed "s:VALUE1:$(HOSTNAME):" ingress.tmpl > ingress.yaml

	@helm install mapproxy  helm/wcereal-tiler/mapproxy  --namespace=argo --wait -f values.yaml 

	# create ingress for WCTiller
	@kubectl delete -f ingress.yaml


	# waiting 20 secondes before install oidc plugin
	sleep 20

	# install oidc plugin on wctiller route
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/wctiller.wctiller.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=wctiller' \
	--data 'config.client_secret=2738c0a4-85be-44b0-8784-125b0ec8feac' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"




delete :
	# Deploy WCTiller
	kubectl delete -f ingress.yaml
	@helm uninstall mapproxy  helm/wcereal-tiler/mapprox  -n wctiller 

