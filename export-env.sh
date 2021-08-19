#!/bin/bash


export TARGET_CLUSTER="ewoc-prod"
export HOSTNAME="worldcereal.csgroup.space"

# Kong conf
export KONG_CHART_VERSION="2.1.0"
export KONG_VERSION="2.4-ubuntu"

export POSTGRESQL_CHART_VERSION="10.3.15"

# Keycloak conf
export KEYCLOAK_CHART_VERSION="2.4.7"
export KEYCLOAK_VERSION="12.0.4-debian-10-r69" 

# Kube-Prometheus-Stack
export KUBE_PROMETHEUS_STACK_CHART_VERSION="17.0.2"