FROM alpine:latest
MAINTAINER Jeroen Geusebroek <me@jeroengeusebroek.nl>

ENV APK_ADD="sudo git py2-pip python py-libxml2 py-lxml py-pip make gcc g++ python-dev openssl-dev libffi-dev" \
    APK_DEL="make gcc g++ git python-dev openssl-dev libffi-dev" \
    REFRESHED_AT='2017-01-03'

RUN apk add --no-cache ${APK_ADD} && \
    pip --no-cache-dir install pyopenssl && \

    # Clone Couchpotato
    git clone --depth 1 https://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato && rm -rf /opt/couchpotato/.git

RUN apk del --no-cache ${APK_DEL}

VOLUME [ "/config", "/media" ]

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x  /entrypoint.sh

EXPOSE 5050

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ ""]