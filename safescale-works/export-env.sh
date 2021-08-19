#!/bin/bash


# set env variable for Prod cluster
if [ "$USER" == "ewoc-prod" ]; then
    export TARGET_CLUSTER="ewoc-prod"
    #export HOSTNAME="prod.esa-worldcereal.org"
    export HOSTNAME="185.178.85.22"
    export FLOATING_IP="185.178.85.22"
    echo "test"

# set env variable for Test cluster
elif [ "$USER" == "ewoc-test" ]; then
    export TARGET_CLUSTER="ewoc-test"
    export HOSTNAME="test.esa-worldcereal.org"
    export FLOATING_IP="xxx.xxx.xxx.xxx"

else 
    echo "USER env variable is missing, it's mandatory, you must run the script with the safescale ewoc user: prod or test"
    exit 0 
fi


# Kong conf
export KONG_CHART_VERSION="2.1.0"
export KONG_VERSION="2.4"

# Keycloak conf
export KEYCLOAK_CHART_VERSION="2.4.7"
export KEYCLOAK_VERSION="12.0.4-debian-10-r69" 

# Kube-Prometheus-Stack
export KUBE_PROMETHEUS_STACK_CHART_VERSION="17.0.2"