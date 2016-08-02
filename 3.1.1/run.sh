#!/bin/bash -e

if [ ! -z ${GF_AWS_PROFILES+x} ]; then
    mkdir -p /grafana/.aws/
    touch /grafana/.aws/credentials

    for profile in ${GF_AWS_PROFILES}; do
        access_key_varname="GF_AWS_${profile}_ACCESS_KEY_ID"
        secret_key_varname="GF_AWS_${profile}_SECRET_ACCESS_KEY"
        region_varname="GF_AWS_${profile}_REGION"

        if [ ! -z "${!access_key_varname}" -a ! -z "${!secret_key_varname}" ]; then
            echo "[${profile}]" >> /grafana/.aws/credentials
            echo "aws_access_key_id = ${!access_key_varname}" >> /grafana/.aws/credentials
            echo "aws_secret_access_key = ${!secret_key_varname}" >> /grafana/.aws/credentials
            if [ ! -z "${!region_varname}" ]; then
                echo "region = ${!region_varname}" >> /grafana/.aws/credentials
            fi
        fi
    done

    chown grafana:grafana -R /grafana/.aws
    chmod 600 /grafana/.aws/credentials
fi

if [ ! -z ${GF_INSTALL_PLUGINS} ]; then
  OLDIFS=$IFS
  IFS=','
  for plugin in ${GF_INSTALL_PLUGINS}; do
    grafana-cli plugins install ${plugin}
  done
  IFS=$OLDIFS
fi

exec dumb-init gosu grafana grafana-server  \
  --homepath=/grafana
