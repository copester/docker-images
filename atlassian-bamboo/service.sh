#!/bin/sh

# LD_LIBRARY_PATH modification is required for libtcnative to be loaded
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/x86_64-linux-gnu"

exec /sbin/setuser bamboo /opt/bamboo/bin/start-bamboo.sh -fg
