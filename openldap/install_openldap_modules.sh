#!/bin/bash

set -e

# Ensure we have something to work with
[ ! -d /tmp/buildctx/modules.d ] && exit 0
[ -z "$(find /tmp/buildctx/modules.d -iname Makefile)" ] && exit 0

# Prepare our compilation tools
apt-get update
DEBIAN_FRONTEND="noninteractive" apt-get install -qy build-essential equivs devscripts gdebi-core

# Generate a .deb representing openldap's build-deps and install it
cd /usr/src
mk-build-deps openldap
gdebi -qn openldap-build-deps_*.deb

# Build the OpenLDAP tree
DEB_BUILD_OPTIONS="nocheck" apt-get source -b openldap
# And our additional modules
SRC_DIR="/usr/src/$(basename /usr/src/openldap-2*)"
for MOD_DIR in /tmp/buildctx/modules.d/*; do \
	make -C "${MOD_DIR}" LDAP_SRC="${SRC_DIR}" LDAP_BUILD="${SRC_DIR}/debian/build"
	make -C "${MOD_DIR}" install LDAP_SRC="${SRC_DIR}" LDAP_BUILD="${SRC_DIR}/debian/build"
done

# Clean up - remove build deps and toolchain
apt-get autoremove -qy build-essential equivs devscripts gdebi-core openldap-build-deps
apt-get clean
rm -rf /usr/src/* /var/lib/apt/lists/* /tmp/* /var/tmp/*
