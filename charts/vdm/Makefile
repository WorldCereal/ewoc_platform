.PHONY: build deploy delete
	
build:

	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Building VDM stack: namespace, secrets & pvc
	
	# Creating namespace & harbor secret	
	@kubectl apply -f init/init.yaml

	# Creating pvc
	@kubectl apply -f pvc/pg-data-pvc.yaml

	# Templating ConfigMaps
	@sed "s:VALUE1:$(HOSTNAME):" config/app-wcpdr/runtimeConfig.tmpl > config/app-wcpdr/runtimeConfig.js
	@sed "s:VALUE1:$(HOSTNAME):;s:VALUE2:$(HOSTNAME):" config/be/config.tmpl > config/be/config.js

	# Creating configMaps
	@kubectl create configmap -n vdm  pg-hostpath1 --from-file=config/postgresql/postgresql.conf
	@kubectl create configmap -n vdm  app-wcpdr-hostpath0 --from-file=config/app-wcpdr/runtimeConfig.js
	@kubectl create configmap -n vdm  be-hostpath0 --from-file=config/be/config.js


deploy:
	
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Genarate app-wcpdr-deployment.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" deployments/app-wcpdr-deployment.tmpl > deployments/app-wcpdr-deployment.yaml

	# Genarate values.yaml from template file
	@sed "s:VALUE1:$(HOSTNAME):" ingress/ingress.tmpl > ingress/ingress.yaml

	# Creating deployments & services
	@kubectl apply -f deployments/app-wcpdr-deployment.yaml -n vdm
	@kubectl apply -f deployments/be-deployment.yaml -n vdm 
	@kubectl apply -f deployments/pg-deployment.yaml -n vdm
	@kubectl apply -f deployments/redis-deployment.yaml -n vdm

	# Creating Ingress 
	@kubectl apply -f ingress/ingress.yaml -n vdm

	# waiting 20 secondes before install oidc plugin
	sleep 20

	# POST OIDC setup for VDM routes
	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/vdm.app.00/plugins \
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

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/vdm.app.01/plugins \
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
	
	@kubectl delete ingress -n vdm app

	@kubectl delete deployment -n vdm app-wcpdr
	@kubectl delete deployment -n vdm be
	@kubectl delete deployment -n vdm pg
	@kubectl delete deployment -n vdm redis

	@kubectl delete service -n vdm app-wcpdr
	@kubectl delete service -n vdm be
	@kubectl delete service -n vdm pg
	@kubectl delete service -n vdm redis

	@kubectl delete configmaps -n vdm app-wcpdr-hostpath0
	@kubectl delete configmaps -n vdm be-hostpath0
	@kubectl delete configmaps -n vdm pg-hostpath1


	


