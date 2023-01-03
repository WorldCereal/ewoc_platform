# WorldCereal Expose API 

## Purpose
This document aim to explain how will be exposed your API/Flow online in WorldCereal context.
You will also find a postman file that allow you to test it. 

## Workflows
Your applications are exposed behind Kong that checks with an OIDC plugin linked to Keycloak
if an user has the rights to access applications or not.
There is 2 workflows possibles:
- The first one "Login form", which is the standard one. The user wants to login Kong checks if the user has a valid web browser cookie, if not it redirects the user to the Keycloak login form.

- The second "Bearer token", is the one that will be set to expose API (testable in with postman).
The user has to send a request to the Keycloak API with 4 parameters.
`username`, `password`, `client_id`, `grant_type`.
`client_id`, `grant_type` will always be fix and provided by CS Group.
Once the request is sent, Keycloak should respond with an **access token** if all the provided parameters are correct. 
User can now use the **access token** and put it in his authorization bearer header request.

So we have 2 workflows, one is suited for browser interactions and the second for automation and API usage.

## Limitations of bearer token workflow
- The **access_token** will be available for 10 minutes (could be changed through Keycloak). After this time the user should asks for a new token or ask for a refresh. 

- The second limitation concerns the architecture of the deployed applications.
Each application is exposed by an "ingress" in K8S world. The ingress is linked with Kong that automatically create a **route** for the application. CS teams added an OIDC plugin on the **route** object to protect it with OIDC that ensures authentication provided by Keycloak.
The main issue, is that the OIDC plugin configuration on the route can't be at the same time "Login form" and "Bearer token" it is only one or the other.(That's why if you try to use the bearer token method on your current deployed application the server response will be the Keycloak login form).
So to get around this limitation, every API/WMS flows that you want to expose with "bearer token" configuration must use another url in order to get 2 differents Kong routes.
For instance, we recommend in vdm context to keep the first endpoint as it is vdm.demo.esa-worldcereal.org and add a new one vdmapi.demo.esa-worldcereal.org for bearer token exposed API.


