.PHONY: deploy delete

port=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_port"] ' | base64 --decode ) 
user=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_user"] ' | base64 --decode )
password=$(shell kubectl get secrets -n argo pgsql -o json | jq  -r '.data["postgresql_password"] ' | base64 --decode )

deploy:
	# Deploy WCTiler 
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	
	# Init env
	@kubectl create namespace wctiler
	
	@sed "s:VALUE1:$(HOSTNAME):;s:VALUE2:$(WCT_CS):g" ingress.tmpl > ingress.yaml

	# Create pgsql connexion conf
	@sed "s:HOST:$(WCT_HOST_DB):;s:PORT:$(port):;s:DBNAME:$(WCT_DB_NAME):;s:USER):$(user):;s:PASSWORD:$(password):" chart/config/mapfiles/postgres_connection.inc.map.tmpl > chart/config/mapfiles/postgres_connection.inc.map.sample

	# Set WMS service URL 
	@sed "s:VALUE1:$(HOSTNAME):" chart/config/worldcereal_status.tmpl > chart/config/worldcereal_status.html

	# Install chart
	@helm install mapproxy  chart/  --namespace=wctiler --wait  --set-file mapserver.mapfiles.postgresConnection=chart/config/mapfiles/postgres_connection.inc.map.sample

	# create ingress for WCTiler
	@kubectl apply -f ingress.yaml -n wctiler
	
delete :
	# Delete WCTiler
	@helm delete  mapproxy -n wctiler
	@kubectl delete ingress -n wctiler wctiler

