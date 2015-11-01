#!/bin/sh

cd /etc/inspircd
exec /sbin/setuser irc /usr/sbin/inspircd --nofork
