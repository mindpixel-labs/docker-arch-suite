#!/usr/bin/env bash

# UID/GID map to unknown user/group, $HOME=/ (the default when no home directory is defined)
eval $( fixuid )
# UID/GID now match user/group, $HOME has been set to user's home directory

if [ "$1" = 'crossbar' -a "$(id -u)" = '0' ]; then
    # initialize a Crossbar.io node
	chown -R crossbar:crossbar /node
	exec su-exec crossbar "$@"
fi

# Run CMD
exec "$@"
