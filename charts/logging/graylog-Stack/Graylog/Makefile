.PHONY: build deploy delete config install_pack

password= $(shell kubectl get secrets -n logging mongo-mongodb -o json | jq  -r '.data["mongodb-password"] ' | base64 --decode )
password_admin= $(shell kubectl get secrets -n logging graylog -o json | jq  -r '.data["graylog-password-secret"] ' | base64 --decode )
content_pack_id= $(shell kubectl exec -it -n kong kong-oidc-tool -- curl -s -X GET -u "admin":$(password_admin) -H "X-Requested-By: graylog" -H "Content-Type: application/json" "graylog.logging.svc.cluster.local:9000/api/system/content_packs?pretty=true" | jq -r '.content_packs[] | select(.name=="Kafka").id')

build:
	# Build all components for Graylog
	helm repo add kongz https://charts.kong-z.com
	helm repo update
	
deploy:
	# Deploy all components for Graylog
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@sed "s:VALUE1:$(GRAYLOG_VERSION):" values-graylog.tmpl > values-graylog.yaml
	@sed "s:VALUE1:$(HOSTNAME):;s:VALUE3:$(GRAYLOG_CS):" ingress-graylog.tmpl > ingress-graylog.yaml

	helm install graylog --namespace logging --wait kongz/graylog --version $(GRAYLOG_CHART_VERSION) \
		--set tags.install-mongodb=false \
		--set tags.install-elasticsearch=false \
		--set graylog.mongodb.uri=mongodb://graylog:$(password)@mongo-mongodb.logging.svc.cluster.local/graylog \
		--set graylog.elasticsearch.hosts=http://elastic-elasticsearch-master.logging.svc.cluster.local:9200 \
		--set graylog.elasticsearch.version=7 \
		--set graylog.persistence.size="10Gi" \
    	-f values-graylog.yaml

	# Create Ingress
	kubectl apply -f ingress-graylog.yaml -n logging
	
config:

	kubectl exec -it -n kong kong-oidc-tool -- apk update
	kubectl exec -it -n kong kong-oidc-tool -- apk add jq

	kubectl cp worldcereal_inputs.json -n kong kong-oidc-tool:/tmp 

	# Upload content pack
	kubectl exec -it -n kong kong-oidc-tool -- curl -s -i -X POST -u admin:$(password_admin) -H "Content-Type: application/json" -H "X-Requested-By: cli" "graylog.logging.svc.cluster.local:9000/api/system/content_packs" -d @"/tmp/worldcereal_inputs.json"

install_pack:
	# Install the content pack 
	kubectl exec -it -n kong kong-oidc-tool -- curl -s -i -X POST -u "admin":$(password_admin) -H "Content-Type: application/json" -H "X-Requested-By: cli" "graylog.logging.svc.cluster.local:9000/api/system/content_packs/${content_pack_id}/1/installations" -d '{"parameters": {},"comment": ""}'

delete:
	# Deleting all components for graylog
	helm uninstall graylog -n logging 
	kubectl delete ingress -n logging graylog
	kubectl delete kongplugins.configuration.konghq.com  -n logging graylog-oidc 



