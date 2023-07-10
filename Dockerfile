#!/usr/bin/env -S docker build . --file

#region angie original
FROM alpine:3.18 as base

RUN set -x \
     && apk add --no-cache ca-certificates curl apache2-utils \
     && curl -o /etc/apk/keys/angie-signing.rsa https://angie.software/keys/angie-signing.rsa \
     && echo "https://download.angie.software/angie/alpine/v$(egrep -o \
          '[0-9]+\.[0-9]+' /etc/alpine-release)/main" >> /etc/apk/repositories \
     && apk add --no-cache angie angie-module-dav-ext \
     && rm /etc/apk/keys/angie-signing.rsa \
     && ln -sf /dev/stdout /var/log/angie/access.log \
     && ln -sf /dev/stderr /var/log/angie/error.log

EXPOSE 80

#endregion

FROM base

LABEL org.opencontainers.image.authors="Zverev IV"


ENV USERNAME="" PASSWORD=""

COPY angie.conf /etc/angie/angie.conf

COPY entrypoint.sh /

VOLUME /data

CMD /entrypoint.sh && angie -g "daemon off;"

