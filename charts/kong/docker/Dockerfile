ARG KONG_VERSION 

FROM kong:$KONG_VERSION

# install deck
# RUN curl -sL https://github.com/kong/deck/releases/download/v1.2.0/deck_1.2.0_linux_amd64.tar.gz -o deck.tar.gz && \
# 	tar -xf deck.tar.gz -C /tmp && \
# 	sudo cp /tmp/deck /usr/local/bin/

USER root

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y luarocks curl
RUN luarocks install kong-oidc 

RUN  rm usr/local/share/lua/5.1/kong/plugins/oidc/handler.lua 
COPY handler.lua  usr/local/share/lua/5.1/kong/plugins/oidc/handler.lua 



USER kong

# COPY plugins.yaml /
COPY start.sh /

CMD /start.sh