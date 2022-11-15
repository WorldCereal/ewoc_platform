#!/usr/bin/env bash

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
# aws_token=$(aws ecr get-login-password --region eu-central-1 --profile=admin)
aws_token=$(aws ecr get-login-password --region eu-central-1)

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

# Mongo and Graylog passwords
mongodb=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
mongodbroot=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
mongodbreplicakey=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

kubectl create secret generic mongo-db --type=Opaque --namespace=logging \
	--from-literal="mongodb-passwords=$mongodb" \
	--from-literal="mongodb-root-password=$mongodbroot" \
	--from-literal="mongodb-replica-set-key=$mongodbreplicakey" \
	--dry-run=client -oyaml | kubectl apply -f-

# Generate mongodb URI secret for graylog
kubectl create secret generic mongodb-access --type=Opaque --namespace=logging \
	--from-literal="uri=mongodb://graylog:$mongodb@mongo-mongodb-headless/graylog?replicaSet=rs0" \
	--dry-run=client -oyaml | kubectl apply -f-



