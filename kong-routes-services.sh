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








#test !!!!!
curl -kSsl -X PATCH \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins \
--data 'name=oidc' \
--data 'config.bearer_only=yes' \
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

upstreams
local opts = {} -- a new table
opts["discovery"]["userinfo_endpoint"] = "http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/protocol/openid-connect/userinfo"


# retrieve pluging id
curl -kSsl -X GET \
--url http://kong-kong-admin:8001/plugins \

curl  http://kong-kong-admin:8001/upstreams

# Prometheus Update client_secret
curl -kSsl -X PATCH \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins/3a76eee0-d42e-48db-a90a-b6934b988540 \
--data 'config.bearer_only=no' 

curl -kSsl -X DELETE \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins/0ab43d7d-c65d-40b9-b606-addb3631ed95 \
#--data 'config.userinfo_header_name=myvariable'

--data 'config.downstream_access_token_header' \
--data 'config.downstream_user_info_header'

--data 'config.client_secret=f59de7a5-caf5-474b-ae28-3ca6e29462a7' \



# Grafana Update client_secret
curl -kSsl -X PATCH \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-grafana.00/plugins/1c44198a-06a7-48c8-bc9a-824de59410fa \
--data 'config.client_secret=f83a7e0e-8603-4fa7-b71f-c1c997591c3e' \

# Check if plugin is avaible on the specific route
curl -kSsl -X GET \
--url http://kong-kong-admin:8001/routes/monitoring.kube-prometheus-stack-prometheus.00/plugins/


{"data":[{"id":"1c44198a-06a7-48c8-bc9a-824de59410fa","protocols":["grpc","grpcs","http","https"],"service":null,"route":{"id":"a0d28cc4-91c0-41f4-8f8d-57f7809819b4"},"config":{"redirect_after_logout_uri":"/","discovery":"http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/.well-known/openid-configuration","introspection_endpoint_auth_method":null,"redirect_uri_path":null,"session_secret":"null","logout_path":"/logout","client_id":"grafana","response_type":"code","introspection_endpoint":null,"recovery_page_path":null,"bearer_only":"no","token_endpoint_auth_method":"client_secret_post","ssl_verify":"\"no\"","client_secret":"f83a7e0e-8603-4fa7-b71f-c1c997591c3e","filters":null,"scope":"openid","realm":"worldcereal"},"tags":null,"enabled":true,"created_at":1630413863,"name":"oidc","consumer":null},{"id":"ade25823-604b-407f-bc58-d4731eb67d73","protocols":["http","https"],"service":null,"route":null,"config":{"secret":"opensesame","cookie_path":"/","cookie_domain":null,"cookie_samesite":"Strict","cookie_httponly":true,"cookie_secure":true,"cookie_idletime":null,"cookie_renew":600,"logout_post_arg":"session_logout","cookie_discard":10,"cookie_name":"session","storage":"cookie","logout_methods":["POST","DELETE"],"cookie_lifetime":3600,"logout_query_arg":"session_logout"},"tags":["managed-by-ingress-controller"],"enabled":true,"created_at":1631027079,"name":"session","consumer":null}],"next":null}