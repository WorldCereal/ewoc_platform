.PHONY:  deploy 


deploy:
	#check if env variable are set
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	# build image 
	docker build . -t hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/kong:$(KONG_VERSION) -f Dockerfile --build-arg KONG_VERSION=$(KONG_VERSION)
	
	# deploy image on harbor registry
	docker push hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/kong:$(KONG_VERSION) 