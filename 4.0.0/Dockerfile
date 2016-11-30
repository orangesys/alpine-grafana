FROM alpine:3.4
MAINTAINER "Gavin zhou" <gavin.zhou@gmail.com>

ENV GRAFANA_VERSION=v4.0.0

RUN set -ex && \
    addgroup -S grafana && \ 
    adduser -S -G grafana grafana && \
    export GOPATH=/go && \
    PATH=$PATH:$GOPATH/bin && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community go dumb-init && \
    buildDeps="build-base nodejs git python curl make gcc musl-dev" && \
    apk add --no-cache $buildDeps ca-certificates openssl fontconfig bash && \
    curl -sL https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    mkdir -p ${GOPATH}/src/github.com/grafana && \
    cd ${GOPATH}/src/github.com/grafana && \
    git clone -b ${GRAFANA_VERSION} --depth 1 https://github.com/grafana/grafana.git &&\
    cd grafana && \
    go run build.go setup && \
    go run build.go build && \
    npm install && \
    npm run build && \
    npm cache clear && \
    mkdir -p /grafana/dashboards && \
    mkdir /grafana/data && \
    mkdir /grafana/logs && \
    mkdir /grafana/plugins && \
    cp -a ${GOPATH}/src/github.com/grafana/grafana/bin/grafana-server /usr/local/bin/grafana-server && \
    cp -a ${GOPATH}/src/github.com/grafana/grafana/bin/grafana-cli /usr/local/bin/grafana-cli && \
    cp -ra ${GOPATH}/src/github.com/grafana/grafana/public_gen /grafana/public && \
    cp -ra ${GOPATH}/src/github.com/grafana/grafana/conf /grafana/conf && \
    cp -ra ${GOPATH}/src/github.com/grafana/grafana/vendor /grafana/ && \
    mkdir /var/lib/grafana/ && \
    ln -s /grafana/plugins /var/lib/grafana/plugins && \ 
    grafana-cli plugins update-all && \
    go clean -i -r && \
    apk del --purge $buildDeps go && \
    rm -rf /go /tmp/* /root/.n* /dumb-init-master* && \
    chown -R grafana:grafana /grafana

VOLUME  ["/grafana"]
COPY ./config.docker/defaults.ini /grafana/conf/
COPY ./run.sh /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
