Deploy the application by playing make deploy

The Size of the requests/responses are blocked by mapserver.
For now exec kubectl exec -it -n wctiler mapserver-*
and update the uwsgi.ini file with buffer-size=32768
and play the following command: 
uwsgi --reload /tmp/map.pid uwsgi.ini