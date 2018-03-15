#!/usr/bin/env bash

if [ "$1" = 'crossbar' -a "$(id -u)" = '0' ]; then
    # initialize a Crossbar.io node
	chown -R crossbar:crossbar /node
	exec su-exec crossbar "$@"
fi

# Run CMD
exec "$@"
