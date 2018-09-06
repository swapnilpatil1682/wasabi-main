#!/usr/bin/env sh
###############################################################################
# Entrypoint for wasabi docker image : 
###############################################################################
set -e



if [ "$1" = 'wasabi' ]; then
    cd /usr/local/wasabi/modules/main/target/
    exec ./wasabi-main-1.0.20180226051442-SNAPSHOT-development/bin/run "$@"
fi

exec "$@"
