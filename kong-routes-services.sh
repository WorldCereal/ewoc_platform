#!/bin/bash

# Prometheus
curl -kSsl -X POST \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins \
--data 'name=oidc' \
--data 'config.bearer_only=no' \
--data 'config.client_id=prometheus' \
--data 'config.introspection_endpoint=http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/protocol/openid-connect/token/introspect' \
--data 'config.client_secret=f59de7a5-caf5-474b-ae28-3ca6e29462a7' \
--data 'config.discovery=http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
--data 'config.realm=worldcereal' \
--data 'config.response_type=code' \
--data 'config.scope=openid' \
--data 'config.session_secret=null' \
--data 'config.ssl_verify="no"' \
--data 'config.token_endpoint_auth_method=client_secret_post' \
--data 'enabled=true' \


# Grafana
curl -kSsl -X POST \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-grafana.00/plugins \
--data 'name=oidc' \
--data 'config.bearer_only=no' \
--data 'config.client_id=grafana' \
--data 'config.client_secret=f83a7e0e-8603-4fa7-b71f-c1c997591c3e' \
--data 'config.discovery=http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
--data 'config.realm=worldcereal' \
--data 'config.response_type=code' \
--data 'config.scope=openid' \
--data 'config.session_secret=null' \
--data 'config.ssl_verify="no"' \
--data 'config.token_endpoint_auth_method=client_secret_post' \
--data 'enabled=true' \
