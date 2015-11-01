FROM phusion/baseimage:latest

ENV ANOPE_VERSION=2.0.2

ADD https://github.com/anope/anope/releases/download/${ANOPE_VERSION}/anope-${ANOPE_VERSION}-source.tar.gz /usr/src/anope.tar.gz
ADD modules /tmp/modules
ADD config.cache /tmp/config.cache

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential cmake libgnutls-dev pkg-config && \
    cd /usr/src && \
    tar xzf anope.tar.gz && \
    cd anope-${ANOPE_VERSION}-source && \
    cp /tmp/config.cache ./ && \
    cp /tmp/modules/* modules/third/ && \
    ln -s /usr/src/anope-${ANOPE_VERSION}-source/modules/extra/m_ssl_gnutls.cpp modules/ && \
    ./Config -quick && \
    cd build && \
    make && \
    make install && \
    cd / && \
    apt-get autoremove -qy build-essential cmake pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/*

ADD service.sh /etc/service/anope/run

VOLUME ["/opt/anope/conf","/opt/anope/data"]
