Deploy the application by playing make deploy

The Size of the requests/responses are blocked by mapserver.
For now exec kubectl exec -it -n wctiler mapserver-*
and update the uwsgi.ini file with buffer-size=32768
and play the following command: 
uwsgi --reload /tmp/map.pid uwsgi.ini

The application is plugged to the argo postgres.
The data are translated to tiles.
A reverse proxy handle which pods is supposed to be contacted according the ressources needed. 

The WMS flow is handled by mapserver and used in the web application exposed by mapproxy. 

