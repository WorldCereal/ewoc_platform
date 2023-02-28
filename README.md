
# WorldCereal Cluster Deployment

<!-- MarkdownTOC -->

- [Architecture:](#architecture)
- [System Node Group](#system-node-group)
  - [Components](#components)
  - [Namespaces](#namespaces)
  - [Requirements](#requirements)
  - [AWS requirements](#aws-requirements)
  - [Installation:](#installation)
- [Processing Node Group](#processing-node-group)
- [Notes](#notes)
- [Details about the components](#details-about-the-components)
  - [Cert-Manager](#cert-manager)
  - [Postgresql-Ha](#postgresql-ha)
  - [Kong Deployment](#kong-deployment)
  - [Keycloak Deployment](#keycloak-deployment)
  - [Kube-Prometheus-Stack Deployment](#kube-prometheus-stack-deployment)
  - [Logging Stack](#logging-stack)
  - [WCTiler](#wctiler)

<!-- /MarkdownTOC -->


## Architecture:

The World Cereal Processing system is built on top of Kubernetes and uses well-known and tested open-source components.

- Deployed and tested on **Kubernetes v1.22+**,
- The cluster is split (logically) into 2 node groups (one dedicated for [system components](#system-node-group) and one for the [processing](#processing-node-group)) so that each has its own resources ; the split is handled using **node labels**,
- Components are deployed using **helm** (Kubernetes package manager) and **namespaces** to isolate them,
- By default, **every component** is configured to be **highly available** and **fault tolerant** (compatible and tested with AWS spot instances for processing nodes)

## System Node Group

### Components

- [Cert Manager](https://github.com/cert-manager/cert-manager) to handle TLS certificates generation and renewal (Let's Encrypt)
- [PostgreSQL HA](https://github.com/bitnami/charts/tree/main/bitnami/postgresql-ha) as the shared database backend for components that require one (kong, keycloak, etc.)
- [Kong](https://github.com/Kong/charts) as the gateway from outside of the cluster (routes requests to components)
- [Keycloak](https://github.com/bitnami/charts/tree/main/bitnami/keycloak/) as the authentication/authorization manager ; provides a Single Sign-on to all applications
- Logging stack:
  - System/kubernetes logs are fetched using [FluentBit](https://github.com/fluent/helm-charts/tree/main/charts/fluent-bit) and application logs are handled in python
  - All logs are sent to [Graylog](https://github.com/KongZ/charts/tree/main/charts/graylog) which acts as the syslog server / viewer
  - Graylog uses [MongDB](https://github.com/bitnami/charts/tree/main/bitnami/mongodb) to store its configuration and [Elasticsearch](https://github.com/elastic/helm-charts/tree/7.17/elasticsearch) to store the logs it receives ; all logs in ES are sharded across all system nodes for availability and replicated to ensure availability in case of a node failure
  - Graylog's configuration is automated using a Kubernetes job running a small python script using Graylog's REST API (more details about the configuration can be found in the [scripts's header](https://github.com/WorldCereal/ewoc_platform/blob/main/charts/graylog/config.py))
- Monitoring stack: [Prometheus/Grafana](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack), [Thanos](https://github.com/bitnami/charts/tree/main/bitnami/thanos)

### Namespaces

The cluster is composed of 10 specific namespaces.

- **argo**: used by preprocessing modules.             
- **cert-manager**: handle SSL/TLS certificates.     
- **sysdb**: namespace for shared postgresql-ha instance.
- **keycloak**: SSO handle cluster authentication. 
- **kong**: Ingress controller used with OIDC to handle user authentication.           
- **logging**: stack that handle and store the cluster events.            
- **monitoring**: stack for perfomance monitoring.      
- **rdm**: stack regrouping elements related to the Reference Data Module.
- **vdm**: stack regrouping elements related to the Visualization and Dissemination Module.             
- **wctiler**: stack that allows to check tiles processing state.



### Requirements

- A Kubernetes cluster running on version 1.22 or later,
- At least 3 nodes dedicated to the System Node Group with label `system-tag=world-cereal-system` (`kubectl label node NODE_NAME system-tag=world-cereal-system`),
- Access to a registry to store Docker images (public or with credentials).
- a "controller" system (separate computer, dedicated node, etc.) with `kubectl` and `helm` installed. `git` also needs to be available to clone the repository in order to perform the intallation.

### AWS requirements

If using AWS infrastructure, the AWS CLI must be installed as well in order to handle the autoscaling and optionally, the registry credentials commands (automatically handled in the init phase). Will also be usefull to access any AWS S3 buckets.

### Installation:

- Configure you Github access to the EWoC project and then clone the EWoC System repository: \
  `git clone https://github.com/WorldCereal/ewoc_platform && cd ewoc_platform`
- Review all the necessary configuration files in order to customize your installation:
  - the file `export-env.sh` located at the root of the project: it contains the base hostname for the project, all of the chart versions to use, and generates some secrets/passwords with random values
  - All the `values.yml` and `values.tmpl` files in their respective folders under `charts/`,
- Source the file: `source export-env.sh`
- Initialize the cluster with `make init` ; this will update all the helm repositories and run the `sys-init.sh` script which creates the namespaces, the registry secrets, the database password secret, and set up various required components.
- Then, start the installation with `make deploy`. The script will install each component and wait for them to be deployed before going to next one.<br/>You can also install them one by one separately with `make <app>`, (`<app>` one of: `certmgr`, `pgsql`, `kong`, `keycloak`, `thanos`, `monitoring`, `mongo`, `elasticsearch`, `graylog`, `config`, `fluentbit`, `rdm`, `vdm`, `wctiler`).<br/>Beware that some components have dependencies between each other.


## Processing Node Group

[EWoC Processing repository](https://github.com/WorldCereal/ewoc_ProcessingSystem)


## Notes 

- The cluster size evolve according preproccesing needs, so it has two parts, one fix and one dynamic.
All the elements deployed here, must be attached to the fix part which is labeled with system-tag: world-cereal-system. We strongly advise you to check that every component that you deploy use the nodeSelector to restrict pods execution only on the fix part of your cluster.

- Some helm chart used here can be found online (bitnami for instance), however some use containers images that are only present in our private registry.

- **Be careful when removing a component not to delete the linked pvc.**

## Details about the components

### Cert-Manager
Cert-Manager is the component that handle the SSL/TLS certificates for cluster applications.
It use the official helm chart from https://cert-manager.io/docs/installation/helm/.
It is deployed in his own namespace `cert-manager`.

**Please be aware to change the issuer email in export-env.sh through CERT_MANAGER_MAIL variable**

To deploy it:
```
make certmgr
```

### Postgresql-Ha
The data of keycloak, kong, grafana are stored in postgresql-HA. 
All the password have been generated in `sys-init.sh` step.

To deploy it:
```
make pgsql
```

### Kong Deployment 
Kong is the ingress controller of the plateform, it uses the postgresql-ha in order to store configuration data.
An OIDC plugin is added to manage user authentication with the help of the keycloak SSO.

To deploy it:
```
make kong
```

Kong also provide a CRD that allows to configure the OIDC plugin though yaml file.
For instance:
```
apiVersion: configuration.konghq.com/v1
config:
  bearer_only: "no"
  client_id: rdm
  client_secret: TheClientSecret
  discovery: https://YourKeycloakURL/auth/realms/YourRealm/.well-known/openid-configuration
  introspection_endpoint: https://YourKeycloakURL/auth/realms/YourRealm/protocol/openid-connect/token/introspect
  logout_path: /logout
  realm: YourRealm
  redirect_after_logout_uri: /
  redirect_uri_path: null
  response_type: code
  scope: openid
  session_secret: null
  ssl_verify: "no"
  token_endpoint_auth_method: client_secret_post
kind: KongPlugin
metadata:
  name: oidc-plugin
  namespace: yourNamespace
plugin: oidc
```

### Keycloak Deployment 
Keycloak is the SSO of the plateform that handle user authentication.
It uses the postgresql-ha in order to store configuration data.
Keycloak realm `worldcereal` is pre-initialized during the installation.

To deploy it:
```
make keycloak
```

Once Keycloak is up and running, get the admin password then, connect to the web interface.
For each client of worldcereal realm, generate a client secret and add it to `export-env.sh` in `_CS` suffixed variables.
Finnally, source the file by running:
```
source export-env.sh 
```

### Kube-Prometheus-Stack Deployment
The kube-prometheus stack from community is used to monitor the plateform.
It deploys Prometheus, Grafana and Alert manager. 
Grafana relies on postgresql-ha to store data regarding Oauth session users.

To deploy it:
```
make monitoring
```

For infomation: 
- alertmanager-kube-prometheus-stack-alertmanager-0 pod allow to setup and check the prometheus rules.
- kube-prometheus-stack-grafana is the UI endpoint for the monitoring 
- kube-prometheus-stack-prometheus-node-exporter-* is a DaemonSet(deploy a instance on every nodes) that allow to expose metrics to Prometheus. 
- prometheus-kube-prometheus-stack-prometheus-0  this is the heart of prometheus, it fetches the metrics exposed by node-exporter.

### Logging Stack
Check the `logging-stack.md` file.

### WCTiler
WcTiler allow users to check the tiles processing status.
WcTiler is a helm chart that deploy 2 elements, it is required to be plug to one database
that has specific tables pattern to be read of.
The database host and name needs to be set in export-en.sh 

To install it run : 
```cd wctiler```

Create namespace.
```sh
 kubectl create ns wctiler 
```
then 
```sh 
make deploy
```

The application should be accessible at the url wctiler.YOURDOMAIN.
Some change have been made on the WCtiler container image mapproxy because of the HTTP request size
that can be blocked if they execess a buffersize. That lead to not display the tiles.
To fix that, the docker image have been updated. By changing the uwsgi.ini paramter buffersize,
the problem is fixed. 
If the issue persist, log in the container mapproxy and play with uswgi.ini parameters and then update server conf with ```uwsgi --reload /tmp/map.pid uwsgi.ini```.
If your solution fix the issue then update the dockerfile and push you new container image on the habor.


### Reference Data Module (RDM)
Check the [RDM repository](https://github.com/WorldCereal/ewoc_rdm_deploy)

### Visualization Dissemination Module (VDM)
Check the [VDM repository](https://github.com/WorldCereal/gisat-env-world-cereal)


## PV recovery

In case of plateform rebuild, it could be needed to reuse some of the PV as they contains valuable data.
It concerns particularly VDM, RDM and Keycloak volumes. 

If the plateform is rebuilt and ETCD is lost, all the PV are not available anymore in the new K8S context.
This is how reattach the volume and reassociate the to their pods (openstack environment). 

For simplicity, it's advised to rename your volume in your openstack project in order to easily identify the volume owner.

First gather the **volume id** in your openstack context.
then create manually a PV using the following exemple: 

```
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "Name"
spec:
  capacity:
    storage: "20Gi" #Reuse old size
  accessModes:
    - "ReadWriteOnce"
  claimRef:
    namespace: theNS
    name: theNameUsedByPVC   
  cinder:
    volumeID: "Your Openstack volume id"
```
The important part is the claimref part that allows to force the binding between the claim and this manually create PV.

When the PVC is create, **if the PVC name has not changed** it should bind automatically to the PV and by so using the old volume.
