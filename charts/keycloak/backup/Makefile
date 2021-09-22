.PHONY: dump restore  

password= $(shell kubectl get secrets -n keycloak keycloak-postgresql -o json | jq  -r '.data["postgresql-password"] ' | base64 --decode )


dump:
	# dump keycloak database
	kubectl exec keycloak-postgresql-0 -n keycloak -- bash -c "PGPASSWORD=$(password)  pg_dump -U bn_keycloak bitnami_keycloak" > keycloak-database.sql
	
restore:
	# restore keycloak backup database
	cat keycloak-database.sql | kubectl exec -i keycloak-postgresql-0 -- psql -U bn_keycloak -d bitnami_keycloak