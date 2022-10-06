# WorldCereal Cluster Deployment

## Index

- [1. Requirements](#requirements)
- [2. Notes](#notes)
- [3. Namespaces](#namespaces)
- [4. Secret Management](#secret-Management)
- [5. Cert-Manager](#cert-manager)
- [6. Kong](#kong-deployment)
- [7. Keycloak](#keycloak-deployment)
- [8. Kube-Prometheus-Stack](#kube-prometheus-stack-deployment)
- [9. Logging-Stack](#logging-stack)
- [10. WCTiler](#wctiler)
- [11. Reference Data Module (RDM)](#reference-data-module-rdm)
- [12. Visualization Dissemination Module (VDM)](#visualization-dissemination-module-vdm)
- [13. PV recovery](#pv-recovery)

## Requirements

- Kubernetes cluster running on version 1.18 or more.
- a cluster with 6 or more nodes.
- Git clone ewoc_platform on the bastion.
- Nodes that are not going to perform any preproccesing tagged as "ewoc-system".
`kubectl label node THE_NODE system-tag=world-cereal-system`
- Access to the image registry (public or by credential).
- aws cli installed and configured to access your cloud instance.
- Kubectl and helm are installed. 

## Notes 
- The cluster size evolve according preproccesing needs, so it has two parts, one fix and one dynamic.
All the elements deployed here, must be attached to the fix part which is labeled with system-tag: world-cereal-system. We strongly advise you to check that every component that you deploy use the nodeSelector to restrict pods execution only on the fix part of your cluster.

- Version configuration is available on the **export-env.sh** as domain name value. 
Before using the Makefile for your deployment, check that you have sourced the export-env.sh by running the following command : 
```
source export-env.sh 
```

- Some helm chart used here can be found online (bitnami for instance), however some use containers images that are only present in our private registry.

- **Be careful when removing a component not to delete the linked pvc.**

## Namespaces
This cluster is composed of 10 specific namespaces.
- **argo**, used by preprocessing modules.             
- **cert-manager**, handle SSL/TLS certificates.     
- **keycloak**, SSO handle cluster authentication. 
- **kong**, Ingress controller used with OIDC to handle user authentication.           
- **logging**, stack that handle and store the cluster events.            
- **monitoring**, stack for perfomance monitoring.      
- **rdm**, stack regrouping elements related to the Reference Data Module.
- **vdm**, stack regrouping elements related to the Visualization and Dissemination Module.             
- **wctiler**, stack that allows to check tiles processing state.
- **sysdb**, namespace for shared postgresql-ha instance.

## Init
In order to deploy the plateform, you first need to play the following command.
`make init`, this will update all helm repository needed and play the `sys-init.sh`.
This script is going to create all the needed secrets.

## Secret Management
Some deployments use containers images that are stored in a private registry.
To be able to pull thoses images, a secret ```aws-registry``` is created in each namespace listed above.
This secret is created by the script `sys-init.sh`. This script also generate password for postgresql instance, mongodb.

## Cert-Manager
Cert-Manager is the component that handle the SSL/TLS certificates for cluster applications.
It use the official helm chart from https://cert-manager.io/docs/installation/helm/.
It is deployed in his own namespace `cert-manager`.

**Please be aware to change the issuer email in export-env.sh through CERT_MANAGER_MAIL variable**

To deploy it:
```
make certmgr
```

## Postgresql-Ha
The data of keycloak, kong, grafana are stored in postgresql-HA. 
All the password have been generated in `sys-init.sh` step.

To deploy it:
```
make pgsql
```

## Kong Deployment 
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

## Keycloak Deployment 
Keycloak is the SSO of the plateform that handle user authentication.
It uses the postgresql-ha in order to store configuration data.
Keycloak realm `worldcereal` is pre-initialized during the installation.

To deploy it:
```
make keycloak
```

Once Keycloak is up and running, get the admin password then, connect to the web interface.
For each client of worldcereal realm, generate a client secret and add it to `export-env.sh` in _CS suffixed variables.
Finnally, source the file by running:
```
source export-env.sh 
```

## Kube-Prometheus-Stack Deployment
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

## Logging Stack
Check the `logging-stack.md` file.

## WCTiler
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


## Reference Data Module (RDM)
Check the readme in rdm folder.

## Visualization Dissemination Module (VDM)
Check the readme in vdm folder.


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