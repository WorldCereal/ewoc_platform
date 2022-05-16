.PHONY: kong

kong:
	
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Ingress
	@sed "s:VALUE1:$(HOSTNAME):;s:VALUE2:$(VDM_CS):;s:VALUE3:$(VDM_API_CS):g" ingress.tmpl > ingress.yaml
	#@kubectl apply -f ingress.yaml -n vdm 