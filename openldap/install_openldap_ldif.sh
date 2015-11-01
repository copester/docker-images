#!/bin/bash

set -e

# Ensure we have something to work with
[ ! -d /tmp/buildctx/ldif.d ] && exit 0
[ -z "$(find /tmp/buildctx/ldif.d -iname "*.ldif")" ] && exit 0

# Start up openldap, with a trap to shut it down on exit
/etc/service/openldap/run &
function shutdown_openldap() {
	killall slapd
}
trap shutdown_openldap EXIT

# Wait a second for LDAP to come up
sleep 3

# Use ldapadd, not slapadd, because it handles database changing and permission problems
find /tmp/buildctx/ldif.d -iname "*.ldif" -print0 | sort -nz | xargs -0tn 1 ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f
