.PHONY:  deploy 


deploy:

	# build image 
	docker build . -t hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/kong:$(KONG_VERSION) -f Dockerfile --build-arg KONG_VERSION=$(KONG_VERSION)
	
	# deploy image on harbor registry
	docker push hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/kong:$(KONG_VERSION) 