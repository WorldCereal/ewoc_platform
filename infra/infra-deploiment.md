
# Infrastructure Creation on Cloud Ferro with kubernetes v1.18.0

For this procedure , we deploy from our local. 

# 1. Terraform deployment 

## 1.1 Source  openstack credentials

```bash
yourmachine:~/ewoc_platform/infra$  source openrc.sh
```

## 1.2 Source pyvenv
```bash
yourmachine:~/ewoc_platform/infra$ python3 -m venv venv
yourmachine:~/ewoc_platform/infra$ source venv/bin/activate
```


# 1.3 Git clone kubespray release-2.13
```bash
mkdir kubespray-2.13
git clone --branch release-2.13 https://github.com/kubernetes-sigs/kubespray kubespray-2.13/
git clone --branch v0.1 https://gitlab.cloudferro.com/kklimonda/cf2-kubespray kubespray/inventory/cf2-kube kubespray-2.13/inventory/cf2-kube
```



## 1.4  Install Terraform binaries
```bash
(venv) yourmachine:~/ewoc_platform/infra$ cd kubespray-2.13
(venv) yourmachine:~/ewoc_platform/infra/kubespray-2.13$ wget -q "https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip"
(venv) yourmachine:~/ewoc_platform/infra/kubespray-2.13$  sudo apt install unzip
(venv) yourmachine:~/ewoc_platform/infra/kubespray-2.13$ unzip terraform_0.12.20_linux_amd64.zip
(venv) yourmachine:~/ewoc_platform/infra/kubespray-2.13$ sudo mv terraform /usr/bin
```




## 1.5 Terraform init
```bash
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$ terraform init contrib/terraform/openstack
```

## 1.6 Generate SSH key pair
```bash
ssh-keygen
```

note: 
The name of key will be used for the terraform deployment & Kubespray, so don't lost it !

## 1.7 Setup your cluster

```bash
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$ vim cluster.tfvars
```
```sh
# your Kubernetes cluster name here
cluster_name = "prod-ewoc" 

# SSH key to use for access to nodes
public_key_path = "~/.ssh/your_ssh_key.pub"

# image to use for bastion, masters, standalone etcd instances, and nodes
image = "Ubuntu 18.04 LTS"

# user on the node (ex. core on Container Linux, ubuntu on Ubuntu, etc.)
ssh_user = "eouser" # Important don't change this user !!!

# 0|1 bastion nodes
number_of_bastions = 1

flavor_bastion = "14"  # eo1.xsmall

# standalone etcds
number_of_etcd = 0

# masters
number_of_k8s_masters = 0

number_of_k8s_masters_no_etcd = 0

number_of_k8s_masters_no_floating_ip = 1 # that mean we want an master without external ip, so for connect to it , we will use the bastion

number_of_k8s_masters_no_floating_ip_no_etcd = 0

flavor_k8s_master = "18"  # eo1.large

# nodes
number_of_k8s_nodes = 0

number_of_k8s_nodes_no_floating_ip = 4 # that mean we want an master without external ip, so for connect to it , we will use the bastion

flavor_k8s_node = "18"  # eo1.large  , read the cloud ferro documentation choice your host template

# GlusterFS
# either 0 or more than one
#number_of_gfs_nodes_no_floating_ip = 0
#gfs_volume_size_in_gb = 150
# Container Linux does not support GlusterFS
#image_gfs = "Ubuntu 18.04 LTS"
# May be different from other nodes
#ssh_user_gfs = "ubuntu"
#flavor_gfs_node = "18"

# networking
network_name = "prod-ewoc-network"

external_net = "be3cb8d6-5b30-42e7-8fc8-4b5371cd6fe4"

subnet_cidr = "172.16.0.0/24"

floatingip_pool = "external"

bastion_allowed_remote_ips = ["0.0.0.0/0"]

dns_nameservers = ["185.48.234.234", "185.48.234.238"]

```


## 1.8 Install dependencies with pip
pip3 install --upgrade pip

pip install -r kubespray-2.13/requirements.txt
pip install python-openstackclient


## 1.9 Create cluster

```bash
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$ terraform apply -var-file=cluster.tfvars contrib/terraform/openstack
```

note:
the  output return to terraform is:
```yaml
floating_network_id = 5a0a9ccb-69e0-4ddc-9563-b8d6ae9ef06c
k8s_master_fips = []
k8s_node_fips = []
private_subnet_id = c8146f47-742a-4eff-b616-a646a212c893
router_id = 8df39733-1b62-48a3-b02d-2c494a0e664b
```

please note down private_subnet_id = c8146f47-742a-4eff-b616-a646a212c893

We have need for the kubespray deployment.

# 2. Kubespray deployment

Please to waiting 5/10 minuetes after host creation before run kubespray, can be avoid some bugs...

## 2.1 Prerequirement:

- Know the private_subnet_id, it's mandatory.
- Source openrc.sh

## 2.2 Setup Kubespray conf 

```bash
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$ vim group_vars/all/openstack.yml
```

```sh
## When OpenStack is used, Cinder version can be explicitly specified if autodetection fails (Fixed in 1.9: https://github.com/kubernetes/kubernetes/issues/50461)
# openstack_blockstorage_version: "v1/v2/auto (default)"
# openstack_blockstorage_ignore_volume_az: yes
## When OpenStack is used, if LBaaSv2 is available you can enable it with the following 2 variables.
openstack_lbaas_enabled: True
openstack_lbaas_subnet_id: "c645fde8-402c-4a6d-9cb0-25d82400ea87" # replace by your private_subnet_id .
## To enable automatic floating ip provisioning, specify a subnet.
openstack_lbaas_floating_network_id: "be3cb8d6-5b30-42e7-8fc8-4b5371cd6fe4" # replace by your network_id used (external,external2,external3)
## Override default LBaaS behavior
openstack_lbaas_use_octavia: True
# openstack_lbaas_method: "ROUND_ROBIN"
# openstack_lbaas_provider: "haproxy"
# openstack_lbaas_create_monitor: "yes"
# openstack_lbaas_monitor_delay: "1m"
# openstack_lbaas_monitor_timeout: "30s"
# openstack_lbaas_monitor_max_retries: "3"

## To use Cinder CSI plugin to provision volumes set this value to true
## Make sure to source in the openstack credentials
cinder_csi_enabled: true
cinder_csi_controller_replicas: 1
```
```bash
(venv) yourmachine:~/kubespray-2.13/inventory/cf2-kube$ vim group_vars/k8s-cluster/k8s-cluster.yaml
```
```yaml
## Change this variable (v1.16) to v1.18.0
kube_version: v1.18.0

```
## 2.3 Deploy Kubespray
```bash
source openrc.sh
```
Will be used by Cinder. 

```bash
(venv) yourmachine:~/kubespray-2.13$ ansible-playbook --become -i inventory/cf2-kube/hosts cluster.yml
```

The deployment can be last betwen 12 & 15 minutes.

## 2.4 Copy kube.conf

```bash
(venv) yourmachine:~/kubespray-2.13$ ssh eouser@[bastion-ip] mkdir .kube/
(venv) yourmachine:~/kubespray-2.13$ scp inventory/cf2-kube/artifacts/admin.conf eouser@[bastion-ip]:.kube/config
```

## 2.5 Install kubectl binaries on bastion host

```bash
(venv) yourmachine:~/kubespray-2.13$ ssh eouser@[bastion-ip]
eouser@cf2-k8s-bastion-1:~$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
eouser@cf2-k8s-bastion-1:~$ chmod +x kubectl
eouser@cf2-k8s-bastion-1:~$ sudo mv kubectl /usr/local/bin/
```

## 2.6 Test your kubernetes cluster

```bash
eouser@cf2-k8s-bastion-1:~$ kubectl get nodes
NAME                      STATUS   ROLES    AGE   VERSION
cf2-k8s-k8s-master-nf-1   Ready    master   39m   v1.18.0
cf2-k8s-k8s-node-nf-1     Ready    <none>   38m   v1.18.0
cf2-k8s-k8s-node-nf-2     Ready    <none>   38m   v1.18.0
...
```
If your output looks same, all my congratulations, you have a  operational kubernetes !

## 2.7 Install Helm3

```bash
eouser@cf2-k8s-bastion-1:~$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
eouser@cf2-k8s-bastion-1:~$ chmod 700 get_helm.sh
eouser@cf2-k8s-bastion-1:~$ ./get_helm.sh
```

