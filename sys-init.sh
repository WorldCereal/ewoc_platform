#!/usr/bin/env bash

# AWS: kong vdm rdm wctiler
# DB: sysdb kong keycloak

set -e

source export-env.sh

# Creating DB namespace
kubectl get ns sysdb &>/dev/null || kubectl create namespace sysdb
# Generating DB password
dbpasswd=$(openssl rand -base64 32)
# Creating/updating DB secret
kubectl create secret generic system-db --type=Opaque --namespace=sysdb \
		--from-literal="postgresql-password=$dbpasswd" \
		--from-literal="repmgr-password=$(openssl rand -base64 32)" \
		--dry-run=client -oyaml | kubectl apply -f-

# Generate new AWS ECR credentials
# aws_token=$(aws ecr get-login-password --region eu-central-1)
aws_token=$(aws ecr get-login-password --region eu-central-1 --profile=admin)

# Namespace + AWS ECR credentials
for ns in kong keycloak logging monitoring vdm rdm wctiler; do
	echo "Namespace: $ns"
	# Create namespace
	kubectl get ns $ns &>/dev/null || kubectl create namespace $ns
	#Creating/updating AWS registry secret
	kubectl create secret docker-registry aws-registry --namespace=$ns \
				--docker-server=$CS_REGISTRY \
				--docker-username=AWS --docker-password="$aws_token" \
				--dry-run=client -oyaml | kubectl apply -f-
done


# Postgresql secret
for ns in kong keycloak monitoring; do
	echo "Namespace: $ns"
	kubectl create secret generic system-db --type=Opaque --namespace=$ns \
		--from-literal="postgresql-password=$dbpasswd" \
		--dry-run=client -oyaml | kubectl apply -f-
done

