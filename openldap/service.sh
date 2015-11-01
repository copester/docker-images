#!/bin/sh

# -d 0 forces slapd to run in foreground
exec slapd -h "ldap:/// ldapi:///" -g openldap -u openldap -F /etc/ldap/slapd.d -d 0
