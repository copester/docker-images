FROM phusion/baseimage:latest

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -qy ldap-utils \
							 libldap2-dev \
							 slapd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ADD service.sh /etc/service/openldap/run
ADD install_*.sh /usr/local/sbin/

VOLUME /var/lib/ldap
EXPOSE 389

ENTRYPOINT ["/sbin/my_init", "--"]

# Adding the whole build context is far from ideal, but in lieu of a conditional ADD...
ONBUILD ADD . /tmp/buildctx
ONBUILD RUN /usr/local/sbin/install_openldap_modules.sh
ONBUILD RUN /usr/local/sbin/install_openldap_ldif.sh
