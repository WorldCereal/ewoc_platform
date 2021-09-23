.PHONY: dump restore  

password= $(shell kubectl get secrets -n keycloak keycloak-postgresql -o json | jq  -r '.data["postgresql-password"] ' | base64 --decode )


dump:
	# dump keycloak database
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)

	@kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  pg_dump -U bn_keycloak bitnami_keycloak" > keycloak-database.sql
	
restore:
	# restore keycloak backup database
	@test -n "$(CLUSTER_ENV_LOADED)" || (echo 'The env variables should be source before run this script' && exit 1)
	@cat keycloak-db-22-09-2021.sql | kubectl exec -i keycloak-postgresql-0 -- psql -U bn_keycloak -d bitnami_keycloak