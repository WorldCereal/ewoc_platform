
# retrieve pluging id
curl  http://kong-kong-admin:8001/plugins 

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