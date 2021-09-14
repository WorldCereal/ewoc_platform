
# LB seting on Cloud ferro & K8s


# 1. On K8s cluster, setup Kong proxy

Deploy Kong proxy with an service type on Nodeport, go to values.yaml:
```yaml
proxy:
  enabled: true
  type: NodePort
  http:
    nodePort: 32080

  tls:
    nodePort: 32443  
```

# 2  On Cloud Ferro , setup LB

1) Create an Load Balancer on the network where the cluster is deployed.
2) add to pool , all your node on port 32080.
3) Disabling the heath monitoring.



Enjoy your LB :) 

curl -H "Authorization: Bearer xxxxxxxxx" http://auth.worldcereal.csgroup.space/auth/realms/worldcereal/protocol/openid-connect/userinfo

http://auth.worldcereal.csgroup.space/auth/realms/worldceral/protocol/openid-connect/userinfo

