.PHONY: init

LIST = logging vdm rdm wctiler keycloak cert-manager kong monitoring
REGISTRY=https://643vlk6z.gra7.container-registry.ovh.net
DOCKER_USERNAME=
DOCKER_PASSWORD=

init:
	for name in $(LIST); do\
		kubectl create ns $${name};\
		kubectl create secret -n $${name} docker-registry harborcs --docker-server=$(REGISTRY) --docker-username=$(DOCKER_USERNAME) --docker-password=$(DOCKER_USERNAME);\
	done