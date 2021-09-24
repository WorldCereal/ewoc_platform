# Deploy WorldCereal stack

## requirements:

- kubernetes version 1.18 or more.
- a cluster with 6 or more nodes.
- Cinder controller deployed or equivalent on the cluster.
- Git clone ewoc_platform on the bastion.
- Source the file export-env.sh.

## summary


- [1. Kong](#1-.-kong-deployment)
- [2. Keycloak](#2.-keycloak-deployment)
- [2. Keycloak-Database-Setup](#.3.-Keycloak-Setup-Database:-Init-or-Restore-Procedure)
- [4. Kube-Prometheus-Stack](#4.-Kube-Prometheus-Stack-Deployment)
- [5. Logging-Stack](#./charts/logging/readMe.md#deploy-log-stack-worldcereal)

4/ Logging-Stack Deployment
5/ wctiller

### 1. Kong Deployment 

1.1 Go to kong direcory:
```sh
cd ewoc_platform/charts/kong  
```

1.2 Build & deploy via Make
```sh
make build
make deploy
```
1.3 check if all kong's pod are running & up:
```sh
kubectl get pod -n kong
```
output should looks:
```
kong-kong-84dd95ffd9-z2szz        2/2     Running     0          6d2h
kong-kong-init-migrations-xrfqh   0/1     Completed   2          12d
kong-oidc-tool                    1/1     Running     0          22d
kong-postgresql-postgresql-0      1/1     Running     0          12d

```
for infomation: 
- kong-kong-84dd95ffd9-z2szz pod containt 2 container:
    - proxy (Kong Gateway)
    - ingress (Kong Ingress Controller)
- kong-postgresql-postgresql-0 pod  containt a postgres database (used by Kong Admin Api for the oidc plugin, routes , svc , etc)
- kong-oidc-tool is a custom pod that allow to post & update via curl request the Kong Admin Api.

### 2. Keycloak Deployment 

2.1 Go to Keycloak directory:
```sh
cd ewoc_platform/charts/keycloak  
```

2.2 Build & deploy via Make
```sh
make build
make deploy
```
2.3 check if all keycloak's pod are running & up:
```sh
kubectl get pod -n keycloak
```
output should looks:
```
keycloak-0              1/1     Running   0          15d
keycloak-postgresql-0   1/1     Running   0          15d
```

### 3. Keycloak Setup Database: Init or Restore Procedure
```sh
cd backup
```

3.4 First deployment (use a new cluster)

a) drop the database
```sh
make drop
```
b) init the database with the init conf
```sh
make init
```

c) Go on keycloak admin endpoint, change URI redirect for this clients with your new DNS:
    - Grafana
    - Prometheus
    - Graylog


3.5 Restore the database (on a cluster already using) after by example rebuild a Keycloak instance by helm.
a) drop the database
```sh
make drop
```
b) restore the database with current conf
```sh
make init
```

3.6 Dump the DB 

```sh
make dump
```
now a file named YOUR-DNS-keycloak-database.sql shoulded be created in the current directory.


### 4. Kube-Prometheus-Stack Deployment
4.1 Go to Kube-Prometheus-Stack directory:
```sh
cd ewoc_platform/charts/kube-prometheus-stack  
```

4.2 Build & deploy via Make
```sh
make build
make deploy
```
4.3 check if all keycloak's pod are running & up:
```sh
kubectl get pod -n monitoring
```
output should looks:
```
alertmanager-kube-prometheus-stack-alertmanager-0           2/2     Running   0          178m
kube-prometheus-stack-grafana-7f9bfd8c67-jw4zl              2/2     Running   0          178m
kube-prometheus-stack-kube-state-metrics-7d86976bf9-dtgkq   1/1     Running   0          178m
kube-prometheus-stack-operator-59b6fcd87-qdsp4              1/1     Running   0          178m
kube-prometheus-stack-prometheus-node-exporter-2nld5        1/1     Running   0          178m
kube-prometheus-stack-prometheus-node-exporter-88wfl        1/1     Running   0          178m
kube-prometheus-stack-prometheus-node-exporter-nmg5r        1/1     Running   0          178m
kube-prometheus-stack-prometheus-node-exporter-rm8tn        1/1     Running   0          178m
kube-prometheus-stack-prometheus-node-exporter-vkdfj        1/1     Running   0          178m
prometheus-kube-prometheus-stack-prometheus-0               2/2     Running   0          178m
```
for infomation: 
- alertmanager-kube-prometheus-stack-alertmanager-0 pod allow to setup and check the prometheus rules.
- kube-prometheus-stack-grafana is the UI endpoint for the monitoring 
- kube-prometheus-stack-prometheus-node-exporter-* is a DaemonSet(deploy a instance on every nodes) that allow to expose metrics to Prometheus. 
- prometheus-kube-prometheus-stack-prometheus-0  this is the heart of prometheus, it fetches the metrics exposed by node-exporter.
