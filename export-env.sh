#!/bin/bash

export CLUSTER_ENV_LOADED="true"

export CS_REGISTRY=501872996718.dkr.ecr.eu-central-1.amazonaws.com
# export CS_REGISTRY=643vlk6z.gra7.container-registry.ovh.net
export REGISTRY_USER=AWS
# Leave empty when using AWS ECR (auto-generated)
export REGISTRY_PASSWD=

export HOSTNAME="cloud.esa-worldcereal.org"

# Cert Manager 
# export CERT_MANAGER_CHART_VERSION="1.5.4"
export CERT_MANAGER_CHART_VERSION="1.9.1"
#export CERT_MANAGER_MAIL="quentin.maraval@csgroup.eu"
export CERT_MANAGER_MAIL="guillaume.dubreule@csgroup.eu"


# Kong conf
export POSTGRESQL_CHART_VERSION="9.4.2" # -> Postgresql 14.5.0
export KONG_CHART_VERSION="2.13.0"
export KONG_VERSION="2.8.1-alpine"

# Keycloak conf
export KEYCLOAK_CHART_VERSION="10.1.0"

# Kube-Prometheus-Stack 
export KUBE_PROMETHEUS_STACK_CHART_VERSION="41.7.4"

# Thanos
export THANOS_CHART_VERSION="11.6.0"
export THANOS_S3_BUCKET_NAME="thanos"
export THANOS_S3_BUCKET_ENDPOINT="thanos-minio.monitoring.svc.cluster.local:9000"
export THANOS_S3_BUCKET_ACCESS_KEY="thanos"
export THANOS_S3_BUCKET_SECRET_KEY="${THANOS_S3_BUCKET_SECRET_KEY:-$(openssl rand -base64 32)}"
export THANOS_S3_ADMIN_PASSWORD="${THANOS_S3_ADMIN_PASSWORD:-$(openssl rand -base64 32)}"

# Graylog STACK (elastic+mongo+graylog)
export MONGO_CHART_VERSION="13.1.3"

# Limited chart version by Graylog compatibility 
# export ELASTIC_CHART_VERSION="17.9.29" # Elastic 7.17.3 (bitnami)
export ELASTIC_CHART_VERSION="7.17.3" # Elastic 7.17.3 (elastic)

export GRAYLOG_CHART_VERSION="2.1.7" # Graylog 4.2.7
export GRAYLOG_VERSION="4.3.8-1"
export GRAYLOG_KUBECTL_VERSION="$(kubectl version -o json | jq -r .serverVersion.gitVersion)"

# FluentBit
export FLUENTBIT_CHART_VERSION="0.21.1" # FluentBit 2.0.5
# export FLUENTBIT_CHART_VERSION="0.20.8"
# export FLUENTBIT_VERSION="1.9.9"

#WCTiler
export WCT_HOST_DB=""
export WCT_DB_NAME=""
export WCT_DB_TABLE=""
export WCT_DB_USER=""
export WCT_DB_PASSWORD=""
export WCT_DB_PORT=""


# Generating System DB password
export SYSDB_PASSWD="${SYSDB_PASSWD:-$(openssl rand -base64 32)}"

# Keycloak Client Secrets
export GRAYLOG_CS="${GRAYLOG_CS:-$(openssl rand -base64 32)}"
export PROMETHEUS_CS="${PROMETHEUS_CS:-$(openssl rand -base64 32)}"
export GRAFANA_CS="${GRAFANA_CS:-$(openssl rand -base64 32)}"
export WCT_CS="${WCT_CS:-$(openssl rand -base64 32)}"
export RDM_API_CS="${RDM_API_CS:-$(openssl rand -base64 32)}"
export RDM_CS="${RDM_CS:-$(openssl rand -base64 32)}"
export VDM_CS="${VDM_CS:-$(openssl rand -base64 32)}"
export VDM_API_CS="${VDM_API_CS:-$(openssl rand -base64 32)}"
export API_CS="${API_CS:-$(openssl rand -base64 32)}"


