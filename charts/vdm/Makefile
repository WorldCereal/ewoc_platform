.PHONY: kong

kong:
	
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Ingress
	@sed "s:VALUE_HOSTNAME:$(HOSTNAME):;s:VDM_CS:$(VDM_CS):;s:VDM_API_CS:$(VDM_API_CS):g" ingress.tmpl > ingress.yaml
	@kubectl apply -f ingress.yaml -n vdm 