#!/bin/bash

# Prometheus
curl -kSsl -X POST \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins \
--data 'name=oidc' \
--data 'config.bearer_only=no' \
--data 'config.client_id=prometheus' \
--data 'config.client_secret=f63a3bcb-8050-4bd7-9f8a-53f8a5a4a2ef' \
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
--data 'config.client_secret=09442b70-9092-441e-9eb1-b504d46e3695' \
--data 'config.discovery=http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration' \
--data 'config.realm=worldcereal' \
--data 'config.response_type=code' \
--data 'config.scope=openid' \
--data 'config.session_secret=null' \
--data 'config.ssl_verify="no"' \
--data 'config.token_endpoint_auth_method=client_secret_post' \
--data 'enabled=true' \
