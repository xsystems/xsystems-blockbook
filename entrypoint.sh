#!/bin/sh

if [ -z "${BITCOIN_HOST}" ] ; then
    echo "The variable BITCOIN_HOST is NOT set, BUT is required"
    exit 1
fi

if [ -z "${BITCOIN_PORT_RPC}" ] ; then
    echo "The variable BITCOIN_PORT_RPC is NOT set, BUT is required"
    exit 1
fi

if [ -z "${BITCOIN_PORT_ZMQ}" ] ; then
    echo "The variable BITCOIN_PORT_ZMQ is NOT set, BUT is required"
    exit 1
fi

wait-for-it --host="${BITCOIN_HOST}" \
            --port="${BITCOIN_PORT_RPC}" \
            --timeout=3600

envsubst < /blockbook/blockchaincfg-template.json > /blockbook/blockchaincfg.json

exec /blockbook/bin/blockbook   -blockchaincfg=/blockbook/blockchaincfg.json \
                                -sync \
                                -internal=:9030 \
                                -public=:9130 \
                                -logtostderr \
                                "$@"
