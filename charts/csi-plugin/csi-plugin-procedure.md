# 1) Add CSI Plugin & Update Helm repo

Go to your master host -> lien vers safescale procedure
+ lien vers l'article 5.1 de la doc

```
helm repo add cpo https://kubernetes.github.io/cloud-provider-openstack
helm repo update
```

 2) Create a privileged namespace for CSI Plugin

 ```
kubectl apply -f privileged-namespace-csi.yaml 
 ```

```
   [Global]
      auth-url=https://cf2.cloudferro.com:5000/v3
      username="your-ursername"
      password="your-password"
      region="your-region"
      domain-name="your-region"
      tenant-id="your-tenant-ID"
      tenant-name="your-tenant-name"
```