.PHONY: dump restore drop init

password= $(shell kubectl get secrets -n keycloak keycloak-postgresql -o json | jq  -r '.data["postgresql-password"] ' | base64 --decode )


dump:
	# dump keycloak database
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  pg_dump -U bn_keycloak bitnami_keycloak" > $(HOSTNAME)-keycloak-database.sql
	
restore:
	# restore keycloak backup database
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  psql -U bn_keycloak -d bitnami_keycloak -c "CREATE DATABASE bitnami_keycloak;"
	cat $(HOSTNAME)-keycloak-database.sql | kubectl exec -i keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  psql -U bn_keycloak -d bitnami_keycloak" 
	# restard pod for the cache issue.
	kubectl delete keycloak-0 -n keycloak

drop:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	# kubectl delete keycloak-postgresql-0 -n keycloak
	kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  dropdb -f -U bn_keycloak -d bitnami_keycloak"


init:
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  psql -U bn_keycloak -d bitnami_keycloak -c "CREATE DATABASE bitnami_keycloak;""
	cat worldcereal-keycloak-db-22-09-2021.sql | kubectl exec -i keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  psql -U bn_keycloak -d bitnami_keycloak" 
	# restard pod for the cache issue.
	kubectl delete keycloak-0 -n keycloak

	