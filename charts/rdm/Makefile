.PHONY: deploy  

deploy:
	# deploy oidc plugin for RDM 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm-ingress.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=ca036e8b-7c36-43ea-91d2-4c8629bc2ca1' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify="no"' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"