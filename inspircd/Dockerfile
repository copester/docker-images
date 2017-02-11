FROM phusion/baseimage:latest

ENV INSPIRCD_VERSION=2.0.23

ADD https://github.com/inspircd/inspircd/archive/v${INSPIRCD_VERSION}.tar.gz /usr/src/inspircd.tar.gz

# N.B. Uses /tmp as the base dir since it's only used for a wrapper script and creating some unneeded directories
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential libgnutls-dev pkg-config && \
    cd /usr/src && \
    tar xzf inspircd.tar.gz && \
    cd inspircd-${INSPIRCD_VERSION} && \
    ./configure --enable-gnutls --prefix=/tmp/inspircd --config-dir=/etc/inspircd --log-dir=/var/log/inspircd --data-dir=/var/lib/inspircd --module-dir=/usr/lib/inspircd --binary-dir=/usr/sbin --uid=irc && \
    make -j`getconf _NPROCESSORS_ONLN` && \
    make INSTUID=irc install && \
    cp /etc/inspircd/examples/inspircd.conf.example /etc/inspircd/inspircd.conf && \
    mkdir -p /var/log/inspircd && \
    chown irc:adm /var/log/inspircd && \
    cd / && \
    rm -rf /usr/src/inspircd-${INSPIRCD_VERSION} && \
    apt-get autoremove -qy build-essential libgnutls-dev pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD install_inspircd_modules.sh /usr/local/sbin/
ADD service.sh /etc/service/inspircd/run

ONBUILD ADD . /tmp/buildctx
ONBUILD RUN /usr/local/sbin/install_inspircd_modules.sh

VOLUME ["/etc/inspircd", "/var/lib/inspircd","/var/log/inspircd"]
