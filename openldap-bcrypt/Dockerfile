FROM predakanga/openldap

# Re-add the onbuild instructions, as this is meant as an intermediate image
ONBUILD ADD . /tmp/buildctx
ONBUILD RUN /usr/local/sbin/install_openldap_modules.sh
ONBUILD RUN /usr/local/sbin/install_openldap_ldif.sh

