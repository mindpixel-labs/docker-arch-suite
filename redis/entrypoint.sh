#!/usr/bin/env bash

set -e

# UID/GID map to unknown user/group, $HOME=/ (the default when no home directory is defined)
eval $( fixuid )
# UID/GID now match user/group, $HOME has been set to user's home directory

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec su-exec redis "$0" "$@"
fi

exec "$@"
