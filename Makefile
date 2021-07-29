.PHONY: build deploy  build2


build:
	# Building all component

	# csi-plugin build 
	cd charts/csi-plugin && make build

	# kong-ingress build 
	cd charts/kong && make build

	# keycloak build 
	cd charts/keycloak && make build

		
deploy:
	# Deploy all component

	# csi-plugin deploy 
	cd charts/csi-plugin && make deploy
	# wait 60s for Cinder was up
	sleep 60

	# kong-ingress build 
	cd charts/kong && make deploy
	# wait 30s for Cinder was up
	sleep 30
	
	# keycloak build 
	cd charts/keycloak && make deploy

build2:
	# 1. faire sed ou voir pour exporter variables.	

	# 2. copy script from aws machine to gateway
	safescale ssh copy kong-routes-services.sh  gw-ewoc-prod:/tmp/
 
	# 3. execute script 
	safescale run -c "bash /tmp/kong-routes-services.sh" gw-ewoc-prod

	