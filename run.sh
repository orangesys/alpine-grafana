#!/bin/sh
set -e

if [ -n "$GF_INSTALL_PLUGINS" ]; then
	printf '%s' "$GF_INSTALL_PLUGINS" |
		tr ',' '\n' |
		while read -r plugin; do
		grafana-cli plugins install ${plugin}
	done
fi

if [ "$(stat -c "%U:%G" /grafana/data)" != grafana:grafana ]; then
	chown grafana:grafana /grafana/data
fi

exec su-exec grafana grafana-server --homepath=/grafana
