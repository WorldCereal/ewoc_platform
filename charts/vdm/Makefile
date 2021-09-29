.PHONY: build deploy delete
	
build:
	# Building VDM stack: namespace, secrets & pvc
	
	# Creating namespace & harbor secret	
	@kubectl apply -f init/init.yaml

	# Creating pvc
	@kubectl apply -f pvc/be-data-pvc.yaml
	@kubectl apply -f pvc/pg-data-pvc.yaml



deploy:
	#
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Genarate app-wcpdr-deployment.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" deployments/app-wcpdr-deployment.tmpl > deployments/app-wcpdr-deployment.yaml

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" ingress/be-ingress.tmpl > ingress/be-ingress.yaml

	# Creating deployments & services
	@kubectl apply -f deployments/app-wcpdr-deployment.yaml
	@kubectl apply -f deployments/be-deployment.yaml
	@kubectl apply -f deployments/pg-deployment.yaml

	# Creating Ingress 
	@kubectl apply -f ingress/be-ingress.yaml

	# waiting 20 secondes before install oidc plugin
	sleep 20

	# POST OIDC setup for VDM routes
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/vdm.be-service.00/plugins \ #Issue possible here with the route id check this before deploy
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=vdm' \
	--data 'config.client_secret=11c5290a-68f7-4fbd-ab8d-e2a2059e7072' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

delete:

	# Creating deployments, services & ingress
	@kubectl delete -f ingress/be-ingress.yaml

	@kubectl delete -f deployments/app-wcpdr-deployment.yaml
	@kubectl delete -f deployments/be-deployment.yaml
	@kubectl delete -f deployments/pg-deployment.yaml

	


