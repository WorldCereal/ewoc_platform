# WorldCereal Cluster Deployment

## Index

- [1. Requirements](#requirements)
- [2. Notes](#notes)
- [3. Namespaces](#namespaces)
- [4. Secret Management](#secret-Management)
- [5. Cert-Manager](#cert-Manager)
- [6. Kong](#kong-deployment)
- [7. Keycloak](#keycloak-deployment)
- [8. Kube-Prometheus-Stack](#kube-prometheus-stack-deployment)
- [9. Logging-Stack](#logging-stack)
- [10. WCTiler](#wctiler)
- [11. Reference Data Module (RDM)](#reference-data-Module-(RDM))
- [12. Visualization Dissemination Module (VDM)](#visualization-dissemination-module-(VDM))

## Requirements

- Kubernetes cluster running on version 1.18 or more.
- a cluster with 6 or more nodes.
- Cinder controller deployed or equivalent on the cluster to handle storage class/persistance.
- Git clone ewoc_platform on the bastion.
- Nodes that are not going to perform any preproccesing tagged as "kong"

## Notes 
- The cluster size evolve according preproccesing needs, so it has two parts, one fix and one dynamic.
All the elements deployed here, must be attached to the fix part which is labeled with role: kong. We strongly advise you to check that every component that you deploy use the nodeSelector to restrict pods execution only on the fix part of your cluster.
```
nodeSelector:
  role: kong 
```
If no node selector is present after you deployment, adapt and use the following command to fix the pods.
```
kubectl patch TYPE_OF_OBJECT -n NAMESPACE OBJECT_NAME -p '{"spec": {"template": {"spec": {"nodeSelector": {"role": "kong"}}}}}'
```

- Version configuration is available on the **export-env.sh** as domain name value. 
Before using the Makefile for your deployment, check that you have sourced the export-env.sh by running the following command : 
```
source export-env.sh 
```

- Some helm chart used here can be found online (bitnami for instance), however some used docker image are only present in our private registry.

- **Be careful when removing the component not to delete the pvc otherwise volumes will be deleted on Cloud Ferro .**

## Namespaces
This cluster is composed of 9 specific namespaces.
- **argo**, used by preprocessing modules.             
- **cert-manager**, handle SSL/TLS certificates.     
- **keycloak**, SSO handle cluster authentication. 
- **kong**, Ingress controller used with OIDC to handle user authentication.           
- **logging**, stack that handle and store the cluster events.            
- **monitoring**, stack for perfomance monitoring.      
- **rdm**, stack regrouping elements related to the Reference Data Module.
- **vdm**, stack regrouping elements related to the Visualization and Dissemination Module.             
- **wctiler**, stack that allow to check tiles processing state.

## Secret Management
Some deployments use docker images that are stored in a private docker registry.
To retrieve it, some deployments uses a secret named ```harborcs```.
For each namespaces, it is required to add you registry credential by playing the following command
before any deployment.
```kubectl create secret -n NAMESPACE docker-registry harborcs --docker-server=YOUR_REGISTRY --docker-username=REGISTRY_USERNAME --docker-password="REGISTRY_PASSWORD"```

## Cert-Manager
Cert-Manager is the component that handle the SSL/TLS certificates for cluster applications.
It use the official helm chart from https://cert-manager.io/docs/installation/helm/.
It is deployed in his own namespace cert-manager.

**Change the issuer email in export-env.sh in CERT_MANAGER_MAIL**

To deploy move into the cert-manager folder, this will deploy all the element of the chart and create a cluster issuer with the mail that you have provided
```
cd /cert-manager
make build
make deploy
```

To delete cert-manager use ```make delete```.

## Kong Deployment 
Kong is the ingress controller of the plateform.
An OIDC plugin is added to manage user authentication with the help of the keycloak SSO.

First, create the harborcs secret to allow you deployment to pull container images from the private registry.
```kubectl create secret -n NAMESPACE docker-registry harborcs --docker-server=YOUR_REGISTRY --docker-username=REGISTRY_USERNAME --docker-password="REGISTRY_PASSWORD"```

Go to kong direcory:
```sh
cd ewoc_platform/charts/kong  
```

Build & deploy via Make
```sh
make build
make deploy
```
Check if all kong's pod are running & up:
```sh
kubectl get pod -n kong
```
The output should looks like:
```
kong-kong-84dd95ffd9-z2szz        2/2     Running     0          6d2h
kong-kong-init-migrations-xrfqh   0/1     Completed   2          12d
kong-oidc-tool                    1/1     Running     0          22d
kong-postgresql-postgresql-0      1/1     Running     0          12d

```
For infomation: 
- kong-kong-84dd95ffd9-z2szz pod containt 2 container:
    - proxy (Kong Gateway)
    - ingress (Kong Ingress Controller)
- kong-postgresql-postgresql-0 pod  containt a postgres database (used by Kong Admin Api for the oidc plugin, routes , svc , etc)
- kong-oidc-tool is a custom pod that allow to post & update via curl request to the Kong Admin Api. (Deprecated)

## Keycloak Deployment 
Keycloak is the SSO of the plateform that handle user authentication.

Go to Keycloak directory:
```sh
cd ewoc_platform/charts/keycloak  
```

Build & deploy via Make
```sh
make build
make deploy
```
Check if all keycloak's pod are running & up:
```sh
kubectl get pod -n keycloak
```
output should looks:
```
keycloak-0              1/1     Running   0          15d
keycloak-postgresql-0   1/1     Running   0          15d
```

Set up SSL Configuration
For now, keycloak is deployed and available in http, this point is WIP and https should be available by default in the near future. 
For now to use keycloak with https it is required to edit the ingress configuration of keycloack. 
First export it in a yaml file with ```kubectl get ingress -n keycloak keycloak -o yaml > ingress.yaml```.
Then update the ingress by adding the following annotations under metadata tag:
```
cert-manager.io/cluster-issuer: letsencrypt-prod
kubernetes.io/tls-acme: "true"
```
and the following line in spec tag.
```
  tls:
  - hosts:
    - auth.YOUR_HOSTNAME
    secretName: keycloaktls
```
Then apply the ingress to generate the certificate and make SSL available.
```kubectl apply -n keycloak -f ingress.yaml``` , wait few seconds and checks that the certificate has been issued with : ```kubectl get certificate -n keycloak``` the folowwing output is exepected : 
```
NAME           READY   SECRET       AGE
keycloaktls   True    keycloaktls   14d
```
Connect to the administration page of keycloak, change the current realm to master.
Update the frontend URL by updating http to https **https://auth.YOUR_HOSTNAME/auth/**.


## Kube-Prometheus-Stack Deployment
Go to Kube-Prometheus-Stack directory:
```sh
cd ewoc_platform/charts/kube-prometheus-stack  
```

Build & deploy via Make
```sh
make build
make deploy
```
Check if all keycloak's pod are running & up:
```sh
kubectl get pod -n monitoring
```
The Output should looks like:
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
For infomation: 
- alertmanager-kube-prometheus-stack-alertmanager-0 pod allow to setup and check the prometheus rules.
- kube-prometheus-stack-grafana is the UI endpoint for the monitoring 
- kube-prometheus-stack-prometheus-node-exporter-* is a DaemonSet(deploy a instance on every nodes) that allow to expose metrics to Prometheus. 
- prometheus-kube-prometheus-stack-prometheus-0  this is the heart of prometheus, it fetches the metrics exposed by node-exporter.

## Logging Stack
Check the readme in logging folder.

## WCTiler
WcTiler allow users to check the tiles processing status.
WcTiler is a helm chart that deploy 2 elements, it is required to be plug to one database
that has specific tables pattern to be read of.
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


## Reference Data Module (RDM)
Check the readme in rdm folder.

## Visualization Dissemination Module (VDM)
Check the readme in vdm folder.


