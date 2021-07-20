FROM kong:2.4-alpine

LABEL description="Kong 2.4.x + kong-oidc plugin"

USER root
RUN apk update && apk add git unzip luarocks
RUN luarocks install kong-oidc

USER kong