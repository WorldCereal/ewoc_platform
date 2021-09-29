## Install in the current k8s context

```sh
helm install mapproxy . \
  --namespace regards \
  --set-file mapserver.mapfiles.postgresConnection=postgres_connection.inc.map.sample
```

TODO: replace *.sample by actual files. See the samples for inspiration.
