FROM microsoft/dotnet:2.1.500-sdk-alpine3.7
MAINTAINER Sylvain Martin (sylvain@nforcer.com)

ARG OVERLAY_VER="v1.21.7.0"
ARG OVERLAY_URL="https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VER}/s6-overlay-amd64.tar.gz"

# s6 overlay
RUN \
 echo "Fetching the basics" \
 && apk add --no-cache curl nfs-utils rpcbind shadow tzdata \
			ca-certificates coreutils \
 && echo "Fetching s6 overlay" \
 && curl -L -s ${OVERLAY_URL} | tar xvzf - -C / \
 && echo "Creating abc user" \\
 && sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd \
 && groupadd -g 3000 abc  \
 && useradd -u 3001 -g 3000 -d /config -m -s /bin/false abc \
 && mkdir -p /app /config /defaults \
 && chown -R abc:abc /app /config /defaults

##
## INIT
##

COPY rootfs/ /

ENTRYPOINT [ "/init" ]
