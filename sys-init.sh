#!/usr/bin/env bash

set -e

[ -z "$SYSDB_PASSWD" ] && echo 'The env variables should be sourced before running this script' && exit 1

# Creating DB namespace
kubectl get ns sysdb &>/dev/null || kubectl create namespace sysdb

# Creating/updating DB secret
kubectl create secret generic system-db --type=Opaque --namespace=sysdb \
	--from-literal="postgresql-password=$SYSDB_PASSWD" \
	--from-literal="repmgr-password=$(openssl rand -base64 32)" \
	--dry-run=client -oyaml | kubectl apply -f-

# Generate new AWS ECR credentials
# REGISTRY_PASSWD=$(aws ecr get-login-password --region eu-central-1 --profile=admin)
REGISTRY_PASSWD="${REGISTRY_PASSWD:-$(aws ecr get-login-password --region eu-central-1)}"

# Namespace + AWS ECR credentials
for ns in kong keycloak logging monitoring vdm rdm wctiler; do
	echo "Namespace: $ns"
	# Create namespace
	kubectl get ns $ns &>/dev/null || kubectl create namespace $ns
	#Creating/updating AWS registry secret
	kubectl create secret docker-registry aws-registry --namespace=$ns \
		--docker-server=$CS_REGISTRY \
		--docker-username=$REGISTRY_USER --docker-password="$REGISTRY_PASSWD" \
		--dry-run=client -oyaml | kubectl apply -f-
done

# Postgresql secret
for ns in kong keycloak monitoring; do
	echo "Namespace: $ns"
	kubectl create secret generic system-db --type=Opaque --namespace=$ns \
		--from-literal="postgresql-password=$SYSDB_PASSWD" \
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

# Generate Thanos S3 Bucket secret 
sed "s:ENDPOINT:${THANOS_S3_BUCKET_ENDPOINT}:;s:ACCESS_KEY:$THANOS_S3_BUCKET_ACCESS_KEY:;s:SECRET_KEY:$THANOS_S3_BUCKET_SECRET_KEY:;s:NAME:$THANOS_S3_BUCKET_NAME:g" charts/kube-prometheus-stack/objstore.tmpl > objstore.yml 

kubectl create secret generic thanos-objstore-config --type=Opaque --namespace=monitoring \
	--from-file=objstore.yml \
	--dry-run=client -oyaml | kubectl apply -f-

