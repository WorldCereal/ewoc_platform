#!/bin/bash

export CLUSTER_ENV_LOADED="true"

export HOSTNAME="demo.worldcereal.csgroup.space"

# Cert Manager 
export CERT_MANAGER_CHART_VERSION="1.5.4"
export CERT_MANAGER_MAIL="quentin.maraval@csgroup.eu"
# Kong conf
export KONG_CHART_VERSION="2.1.0"
export KONG_VERSION="2.4-ubuntu"

export POSTGRESQL_CHART_VERSION="10.3.15"

# Keycloak conf
export KEYCLOAK_CHART_VERSION="5.0.6"
export KEYCLOAK_VERSION="15.0.2-debian-10-r15" 

# Kube-Prometheus-Stack
export KUBE_PROMETHEUS_STACK_CHART_VERSION="17.0.2"

# FluentBit
export FLUENTBIT_CHART_VERSION="0.16.6"
export FLUENTBIT_VERSION="1.8"

# Kafka 
export KAFKA_CHART_VERSION="14.1.0"
export KAFKA_VERSION="2.8.0-debian-10-r84"

# Graylog STACK (elastic+mongo+graylog)
export MONGO_CHART_VERSION="10.26.1"
export MONGO_VERSION="4.4.9-debian-10-r0"

export ELASTIC_CHART_VERSION="17.0.3"
export ELASTIC_VERSION="7.14.1-debian-10-r8"

export GRAYLOG_CHART_VERSION="1.8.5"
export GRAYLOG_VERSION="4.1.3-1"

#World Cover Tiller
export WCT_VERSION="1.0.0"
