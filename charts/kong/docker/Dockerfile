ARG KONG_VERSION 
FROM kong:$KONG_VERSION

ENV LUAROCKS_VERSION=2.4.4-r2

USER root
RUN apk update && apk add git unzip openssl openssl-dev gcc musl-dev luarocks=${LUAROCKS_VERSION} \
	&& luarocks install luaossl && luarocks install kong-oidc

USER kong

