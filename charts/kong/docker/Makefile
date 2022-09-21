.PHONY:  deploy 


deploy:
	#check if env variable are set
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# build image 
	docker build --rm --force-rm -t $(CS_REGISTRY)/world-cereal/kong-oidc:$(KONG_VERSION) --build-arg KONG_VERSION=$(KONG_VERSION) .

	# deploy image on harbor registry
	docker push $(CS_REGISTRY)/world-cereal/kong-oidc:$(KONG_VERSION)

