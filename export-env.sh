#!/bin/bash

export CLUSTER_ENV_LOADED="true"

export HOSTNAME="ewoc-prod.worldcereal.csgroup.space"

# Cert Manager 
# export CERT_MANAGER_CHART_VERSION="1.5.4"
export CERT_MANAGER_CHART_VERSION="1.9.1"
# export CERT_MANAGER_MAIL="quentin.maraval@csgroup.eu"
export CERT_MANAGER_MAIL="guillaume.dubreule@csgroup.eu"
# Kong conf
# export KONG_CHART_VERSION="2.1.0"
# export KONG_VERSION="2.4-ubuntu"

# export POSTGRESQL_CHART_VERSION="10.3.15"


# Kong conf
export POSTGRESQL_CHART_VERSION="10.14.3"
export POSTGRESQL_VERSION="11.12.0-debian-10-r13"
# export POSTGRESQL_VERSION="14.5-alpine3.16"
export KONG_CHART_VERSION="2.12.0"
export KONG_VERSION="2.8.1-alpine"


# Keycloak conf
# export KEYCLOAK_CHART_VERSION="5.0.6"
#export KEYCLOAK_CHART_VERSION="9.8.1"
export KEYCLOAK_CHART_VERSION="10.1.0"

# export KEYCLOAK_VERSION="15.0.2-debian-10-r15"
#export KEYCLOAK_VERSION="18.0.2-debian-11-r28"

# Kube-Prometheus-Stack 
#export KUBE_PROMETHEUS_STACK_CHART_VERSION="17.0.2"
export KUBE_PROMETHEUS_STACK_CHART_VERSION="40.0.0"

# FluentBit
export FLUENTBIT_CHART_VERSION="0.16.6"
export FLUENTBIT_VERSION="1.8"


# Graylog STACK (elastic+mongo+graylog)
#export MONGO_CHART_VERSION="10.26.1"
export MONGO_CHART_VERSION="13.1.3"
#export MONGO_VERSION="4.4.9-debian-10-r0" # UNUSED

export ELASTIC_CHART_VERSION="17.9.29"
#export ELASTIC_VERSION="7.14.1-debian-10-r8"# UNUSED

#export GRAYLOG_CHART_VERSION="2.1.3"
#export GRAYLOG_VERSION="4.2.3-1" # UNUSED
export GRAYLOG_CHART_VERSION="2.1.7"

#WCTiler
export WCT_VERSION="1.0.0"
export WCT_HOST_DB="postgres-postgresql-0.postgres-postgresql-headless.argo.svc.cluster.local"
export WCT_DB_NAME="world-cereal-wctiler"


# Keycloak Client Secret
export GRAYLOG_CS=""
export PROMETHEUS_CS=""
export GRAFANA_CS=""
export WCT_CS=""
export RDM_API_CS=""
export RDM_CS=""
export VDM_CS=""
export VDM_API_CS=""
