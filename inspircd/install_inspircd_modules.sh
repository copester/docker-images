#!/bin/bash

set -e

# Ensure we have something to work with
[ ! -d /tmp/buildctx/modules ] && exit 0

# Prepare our compilation tools
apt-get update
DEBIAN_FRONTEND="noninteractive" apt-get install -qy build-essential libgnutls-dev pkg-config

# Unpack and configure the source
cd /usr/src
tar xzf inspircd.tar.gz
cd inspircd-${INSPIRCD_VERSION}
./configure --enable-gnutls --prefix=/tmp --config-dir=/etc --log-dir=/var/log/inspircd --data-dir=/var/lib/inspircd --module-dir=/usr/lib/inspircd --binary-dir=/usr/sbin --uid=irc

# Compile each of our modules
for m in /tmp/buildctx/modules/*.cpp; do
	MODNAME="$(basename "${m}" .cpp)"
	# Install our build and run dependencies
	BUILDDEPS=""
	RUNDEPS=""
	if [ -f "/tmp/buildctx/modules/${MODNAME}.deps" ]; then
		BUILDDEPS="$(tr -s '\n' ' ' < /tmp/buildctl/modules/${MODNAME}.deps)"
	fi
	if [ -f "/tmp/buildctx/modules/${MODNAME}.rundeps" ]; then
		RUNDEPS="$(tr -s '\n' ' ' < /tmp/buildctl/modules/${MODNAME}.rundeps)"
	fi
	if [ -n "${BUILDDEPS}" ] || [ -n "${RUNDEPS}" ]; then
		DEBIAN_FRONTEND="noninteractive" apt-get install -qy ${BUILDDEPS} ${RUNDEPS}
	fi
	cp "${m}" src/modules/
	make "M=${MODNAME}"
	cp "build/modules/${MODNAME}.so" /usr/lib/inspircd/
	echo "Installed ${MODNAME}"
	if [ -n "${BUILDDEPS}" ]; then
		apt-get autoremove -qy ${BUILDDEPS}
	fi
done

apt-get autoremove -qy build-essential libgnutls-dev pkg-config
apt-get clean
rm -rf /usr/src/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

