FROM alpine:3.4
MAINTAINER "Gavin zhou" <gavin.zhou@gmail.com>

ENV GRAFANA_VERSION=4.0.2-1481203731

RUN set -ex \
    && addgroup -S grafana \
    && adduser -S -G grafana grafana \
    && apk add --no-cache openssl curl bash \
    && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community dumb-init \
    && curl -sL https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64 > /usr/sbin/gosu \
    && chmod +x /usr/sbin/gosu  \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
    && apk add glibc-2.23-r3.apk \
    && wget https://grafanarel.s3.amazonaws.com/builds/grafana-$GRAFANA_VERSION.linux-x64.tar.gz \
    && tar -xzf grafana-$GRAFANA_VERSION.linux-x64.tar.gz \
    && mv grafana-$GRAFANA_VERSION/ grafana/ \
    && mv grafana/bin/* /usr/local/bin/ \
    && mkdir -p /grafana/{dashboards,data,logs,plugins} \
    && rm -f grafana/conf/*.ini \
    && rm grafana-$GRAFANA_VERSION.linux-x64.tar.gz /etc/apk/keys/sgerrand.rsa.pub glibc-2.23-r3.apk \
    && chown -R grafana:grafana /grafana \
    && apk del openssl curl

VOLUME  ["/grafana"]
COPY ./config.docker/defaults.ini /grafana/conf/
COPY ./run.sh /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]

