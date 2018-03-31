#!/usr/bin/env bash

# UID/GID map to unknown user/group, $HOME=/ (the default when no home directory is defined)
eval $( fixuid )
# UID/GID now match user/group, $HOME has been set to user's home directory

# install additional packages
if [[ -n "${PIP_PACKAGES}" ]]; then
    su-exec root pip install ${PIP_PACKAGES}
fi

if [ "$1" = 'crossbar' -a "$(id -u)" = '0' ]; then
    # initialize a Crossbar.io node
	chown -R crossbar:crossbar /node
	exec su-exec crossbar "$@"
fi

# Run CMD
exec "$@"
