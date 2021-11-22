# Deploy WorldCereal stack

## requirements:

- kubernetes version 1.18 or more.
- a cluster with 6 or more nodes.
- Cinder controller deployed or equivalent on the cluster.
- Git clone ewoc_platform on the bastion.
- Source the file export-env.sh.
- Nodes that are not going to perform any preproccesing tagged as "kong"

## summary

- [1. Secret Management](#Secret Management)
- [2. Kong](#kong-deployment)
- [3. Keycloak](#keycloak-deployment)
- [4. Keycloak-Database-Setup](#keycloak-setup-database-init-or-restore-procedure)
- [5. Kube-Prometheus-Stack](#kube-prometheus-stack-deployment)
- [6. Logging-Stack](#./charts/logging/readMe.md#deploy-log-stack-worldcereal)
- [7. WCTiler](#)
- [8. RDM Oidc plugin setup](#rdm-oidc-plugin-setup)
- [9. VDM-stack](#)

### Secret Management
Some deployments use docker images that are stored in a private docker registry.
To retrieve it, some deployments uses a secret named ```harborcs```.
For each namespaces, it is required to add you registry credential by playing the following command
before any deployment.
```kubectl create secret -n NAMESPACE docker-registry harborcs --docker-server=YOUR_REGISTRY --docker-username=REGISTRY_USERNAME --docker-password="REGISTRY_PASSWORD"```

### Kong Deployment 

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

### Keycloak Deployment 

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

### (WIP) Keycloak Setup Database: Init or Restore Procedure
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

### 6. WCTiler
WcTiler allow users to check the tiles processing status.
WcTiler is a helm chart that deploy 2 elements and is required to be plug to one database
that has a specific tables pattern to be read.
The database host and name needs to be set in export-en.sh 

To install it run : 
```cd wctiler```
then 
```make deploy```

The application should be accessible at the url wctiler.YOURDOMAIN.
Some change have been made on the WCtiler container image mapproxy because of the HTTP request size
that can be blocked if they execess a buffersize. That lead to not display the tiles.
To fix that, the docker image have been updated. By changing the uwsgi.ini paramter buffersize,
the problem is fixed. 
If the issue persist, log in the container mapproxy and play with uswgi.ini parameters and then update server conf with ```uwsgi --reload /tmp/map.pid uwsgi.ini```.
If your solution fix the issue then update the dockerfile and push you new container image on the habor.


### 7. RDM

After the deployment of the RDM component, go to charts/rdm for installs oidc plugin on RDM route and use make:
```sh
make deploy
```

### 8. VDM-Stack Deployment

Currently this  VDM-Stack Deployment is in WIP status, that mean:
- The GISAT image will should push on CS Harbor
- Waiting GISAT response about the volume strategy


Go to use vdm directory, use Makefile for in step:
- Build
- Deploy
- Delete

Note:
Be careful when removing the component not to delete the pvc otherwise volumes will be deleted on Cloud Ferro .

### Create acces for RDM administartor
As RDM team wishes to get access to the cluster to play job we recommand
to follow the procedure below. It allow to create a user that can access only to the RDM namespace.

#### Generate SSH Key pair
Rdm user has to generate an ssh key pair, and provide to the cluster amdinistrator 
the public one. 


#### Create user rdm and ssh access
```sudo adduser --shell /bin/rbash --home /home/rdm rdm```
Then connect as rdm :
```su rdm```
and create ssh directory
```mkdir .ssh```
```chmod 700 .ssh```
and add the public key in ```.ssh/authorized_keys``` and execute ```chmod 600 authorized_keys```
At this point you should be able to connect through ssh as rdm user 


#### Configure kubectl 
Now switch to root user, at this point the purpose
is to create a config file for kubernetes to allow user to
access only to his namespace. To dp so, follow the online documentation
and add the config file of kubectl on the /home of RDM.



