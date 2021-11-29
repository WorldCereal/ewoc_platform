.PHONY: kong

kong:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	# Ingress
	@sed "s:VALUE1:$(HOSTNAME):g" ingress.tmpl > ingress.yaml
	@kubectl apply -f ingress.yaml -n rdm 

	# waiting 10 secondes before install oidc plugin
	sleep 10

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=$(RDM_CS)' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify=no' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.$(HOSTNAME)/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.$(HOSTNAME)'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdm.01/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=$(RDM_CS)' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify=no' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'\
    --data 'config.redirect_after_logout_uri=http://auth.$(HOSTNAME)/auth/realms/worldcereal/protocol/openid-connect/logout?redirect_uri=http://rdm.$(HOSTNAME)'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.rdmapiingress.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=$(RDM_CS)' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify=no' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"

	@kubectl exec kong-oidc-tool -n kong -- sh -c "curl -kSsl -X POST \
	--url http://kong-kong-admin:8001/routes/rdm.pgadmin-pgadmin4.00/plugins \
	--data 'name=oidc' \
	--data 'config.bearer_only=no' \
	--data 'config.client_id=rdm' \
	--data 'config.client_secret=$(RDM_CS)' \
	--data 'config.discovery=http://auth.$(HOSTNAME)/auth/realms/worldcereal/.well-known/openid-configuration' \
	--data 'config.realm=worldcereal' \
	--data 'config.response_type=code' \
	--data 'config.scope=openid' \
	--data 'config.session_secret=null' \
	--data 'config.ssl_verify=no' \
	--data 'config.token_endpoint_auth_method=client_secret_post' \
	--data 'enabled=true'"
