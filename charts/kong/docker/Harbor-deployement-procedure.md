# Harbor deployment procedure


## Table of contents

- [Build image for Harbor registry](#Build-image-for-Harbor-registry)
- [Push image on Harbor registry](#Push-image-on-Harbor-registry)
- [Push Helm Chart on Harbor registry](#Push-Helm-Chart-on-Harbor-registry)
- [Add Helm repo with our Harbor registry](#[Add-Helm-repo-with-our-Harbor-registry)


## Build image for Harbor registry

```
docker build . -t hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/[Repository]:[Tag] -f Dockerfile
```
example:
```
docker build . -t hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/suggest-engine:dev -f Dockerfile-from-java-8-jdk-alpine .
```

## Push image on Harbor registry
```
docker push hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/[suggest-engine]:[Tag] 
```
example:
```
docker push hfjcmwgl.gra5.container-registry.ovh.net/world-cereal/suggest-engine:dev 
```
## Push Helm Chart on Harbor registry

For create or update a Helm Chart on Harbor, we need to push it.
### With Harbor UI
- Step 1: compress chart directory
```
tar czvf [my-chart].tgz [your-chart-directory]/
```
- Step 2: Upload chart on https://hfjcmwgl.gra5.container-registry.ovh.net

Click on "UPLOAD"

![Helm Repo](https://ruzickap.github.io/k8s-harbor/assets/img/harbor_project_helm_charts.a0eaa6b9.png)

After you must for "Chart File" choice your my-chart.tgz

![Upload Chart file](https://ruzickap.github.io/k8s-harbor/assets/img/harbor_upload_chart_files.0353006a.png)


### With Harbor CLI

```
helm push --username=<your_username> --password=<your_password>  ./harbor-helm/ 
```

## Add Helm repo with our Harbor registry
```
 helm repo add  snapearth  --username=<your_username> --password=<your_password>  https://hfjcmwgl.gra5.container-registry.ovh.net/chartrepo/snapearth
```