#!/bin/bash


### Add Keycloak Service  #### keycloak.local
curl -kSsl -X POST \
--url https://localhost:8444/services/ \
--data 'name=keycloak' \
--data 'host=keycloak.keycloak.http.svc' \
--data 'port=80' \
--data 'path=/' \
--data 'protocols=http' 



### Add Keycloak route ####

curl -kSsl -X PATCH \
--url https://localhost:8444/services/keycloak/routes \
-- pidc 




curl -kSsl -X GET http://kong-kong-admin:8001/services/

#curl -kSsl -X DELETE --url https://localhost:8444/services/keycloak/routes/3f6ea64b-66c4-4248-a956-f58384305793


# services
{"connect_timeout":60000,"name":"monitoring.kube-prometheus-stack-prometheus.9090","tags":["managed-by-ingress-controller"],"ca_certificates":null,"host":"kube-prometheus-stack-prometheus.monitoring.9090.svc","id":"2e5b29e9-d74a-4e92-8e98-9fcfe1261dab","retries":5,"updated_at":1628867820,"write_timeout":60000,"port":80,"protocol":"http","tls_verify":null,"created_at":1628867820,"path":"/","read_timeout":60000,"tls_verify_depth":null,"client_certificate":null},
{"connect_timeout":60000,"name":"monitoring.kube-prometheus-stack-grafana.80","tags":["managed-by-ingress-controller"],"ca_certificates":null,"host":"kube-prometheus-stack-grafana.monitoring.80.svc","id":"3752e86f-0d35-407f-ae4c-671dac045655","retries":5,"updated_at":1628867823,"write_timeout":60000,"port":80,"protocol":"http","tls_verify":null,"created_at":1628867823,"path":"/","read_timeout":60000,"tls_verify_depth":null,"client_certificate":null},
{"connect_timeout":60000,"name":"keycloak.keycloak.80","tags":["managed-by-ingress-controller"],"ca_certificates":null,"host":"keycloak.keycloak.80.svc","id":"d57c093d-cc5f-407f-a658-59191b24a188","retries":5,"updated_at":1628776297,"write_timeout":60000,"port":80,"protocol":"http","tls_verify":null,"created_at":1628776297,"path":"/","read_timeout":60000,"tls_verify_depth":null,"client_certificate":null}]}



# grafana routes  
{"next":null,"data":[{"regex_priority":0,"name":"monitoring.grafana-ingress.00","snis":null,"destinations":null,"request_buffering":true,"response_buffering":true,"strip_path":false,"https_redirect_status_code":426,"preserve_host":true,"created_at":1628867823,"updated_at":1628867823,"sources":null,"paths":["/"],"methods":null,"service":{"id":"3752e86f-0d35-407f-ae4c-671dac045655"},"hosts":null,"path_handling":"v0","protocols":["http","https"],"id":"20330397-702d-49ad-9251-05f5ccd664c7","tags":["managed-by-ingress-controller"],"headers":null}]}/ 

# prometheus routes
{"regex_priority":0,"name":"monitoring.prometheus-ingress.00","snis":null,"destinations":null,"request_buffering":true,"response_buffering":true,"strip_path":false,"https_redirect_status_code":426,"preserve_host":true,"created_at":1628867823,"updated_at":1628867823,"sources":null,"paths":["/prometheus"],"methods":null,"service":{"id":"2e5b29e9-d74a-4e92-8e98-9fcfe1261dab"},"hosts":null,"path_handling":"v0","protocols":["http","https"],"id":"4e83b35c-8de5-4ae6-9923-4636f14a085d","tags":["managed-by-ingress-controller"],"headers":null}]


 - httpbin.dev2.snapearth.csgroup.space
    name: default.demo.00
    paths:
    - /
    path_handling: v0
    preserve_host: true
    protocols:
    - http
    - https
    regex_priority: 100
    strip_path: false
    tags:
    - managed-by-ingress-controller
    https_redirect_status_code: 426
    plugins:
    - name: oidc
      config:
        bearer_only: "no"
        client_id: monitoring-tools
        client_secret: 8016c419-7808-443b-aefe-2cc6ac5eb98a
        discovery: http://auth.dev2.snapearth.csgroup.space/auth/realms/earthself/.well-known/openid-configuration
        filters: null
        introspection_endpoint: null
        introspection_endpoint_auth_method: null
        logout_path: /logout
        realm: earthself
        recovery_page_path: null
        redirect_after_logout_uri: http://dev2.snapearth.csgroup.space/
        redirect_uri_path: null
        response_type: code
        scope: openid
        session_secret: null
        ssl_verify: "no"
        token_endpoint_auth_method: client_secret_post
      enabled: true
      protocols:
      - grpc
      - grpcs
      - http
      - https