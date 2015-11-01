#!/bin/sh
[ -e /data/.session ] || mkdir -p /data/.session
chown -R rtorrent: /data/.session
rm -f /data/.session/rtorrent.lock
if ! [ -f /data/rutorrent.passwd ]; then
	PASSWD="$(openssl rand -base64 6 2> /dev/null)"
	HASH="$(echo "${PASSWD}" | openssl passwd -stdin)"
	echo "Your ruTorrent password is: ${PASSWD}"
	echo "admin:${HASH}" > /data/rutorrent.passwd
fi
exec /sbin/setuser rtorrent screen -DmS rtorrent -T xterm-256color /opt/rtorrent/bin/rtorrent -n -o import=/data/rtorrent.rc
