#!/bin/bash


export TARGET_CLUSTER="ewoc-prod"
export HOSTNAME="worldcereal.csgroup.space"

# Kong conf
export KONG_CHART_VERSION="2.1.0"
export KONG_VERSION="2.4-ubuntu"

export POSTGRESQL_CHART_VERSION="10.3.15"

# Keycloak conf
export KEYCLOAK_CHART_VERSION="5.0.6"
export KEYCLOAK_VERSION="15.0.2-debian-10-r15" 

# Kube-Prometheus-Stack
export KUBE_PROMETHEUS_STACK_CHART_VERSION="17.0.2"