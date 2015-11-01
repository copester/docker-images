#!/bin/sh

# LD_LIBRARY_PATH modification is required for libtcnative to be loaded
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/x86_64-linux-gnu"

# Unfortunately, crowd doesn't support -fg on start_crowd.sh
exec /sbin/setuser crowd /opt/crowd/apache-tomcat/bin/catalina.sh run
