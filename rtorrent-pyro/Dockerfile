FROM phusion/baseimage:latest

ENV rtorrent_version=0.9.6-20150912-27aa4b7 pyroscope_branch=master rutorrent_version=3.7

RUN add-apt-repository ppa:kalon33/gamesgiroll && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y gdebi-core \
							 mediainfo \
							 miniupnpc \
							 nginx-full \
							 php5-fpm \
							 php5-cli \
							 python-pip \
							 screen \
							 unrar-free \
							 unzip \
							 wget

RUN useradd --system --shell /bin/bash --home-dir /data rtorrent && \
    wget -qO /tmp/rtorrent.deb https://bintray.com/artifact/download/pyroscope/rtorrent-ps/rtorrent-ps_${rtorrent_version}~trusty_amd64.deb && \
    gdebi -n /tmp/rtorrent.deb && rm -f /tmp/rtorrent.deb && \
    pip install https://github.com/pyroscope/pyrobase/zipball/${pyroscope_branch} && \
    pip install https://github.com/pyroscope/pyrocore/zipball/${pyroscope_branch} && \
        wget -qO /tmp/pyrocore.zip https://github.com/pyroscope/pyrocore/zipball/${pyroscope_branch} && \
        unzip -qd /tmp/pyrocore /tmp/pyrocore.zip && \
        cp -Rp /tmp/pyrocore/*/src/pyrocore/data /usr/local/lib/python2.7/dist-packages/pyrocore/ && \
        rm -rf /tmp/pyrocore.zip /tmp/pyrocore && \
    mkdir -p /data/.pyroscope && \
    pyroadmin --config-dir=/data/.pyroscope --create-config && \
    sed -i -e 's:rtorrent_rc = .*:rtorrent_rc = /data/rtorrent.rc:' /data/.pyroscope/config.ini && \
    wget -qO /tmp/rutorrent.zip https://bintray.com/artifact/download/novik65/generic/ruTorrent-${rutorrent_version}.zip && \
    unzip -qd /var/www /tmp/rutorrent.zip && \
    chown -R www-data: /var/www/ruTorrent-master && \
    chmod -R a-w /var/www/ruTorrent-master && \
    chgrp -R rtorrent /var/www/ruTorrent-master/share && \
    chmod -R ug+w /var/www/ruTorrent-master/share && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y gdebi-core

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/*

ADD rtorrent.sh /etc/service/rtorrent/run
ADD nginx.sh /etc/service/nginx/run
ADD php5-fpm.sh /etc/service/php5-fpm/run
ADD rutorrent-config.php /var/www/ruTorrent-master/conf/config.php
ADD plugins.ini /var/www/ruTorrent-master/conf/plugins.ini
ADD rutorrent.ngx /etc/nginx/sites-enabled/default
ADD rtorrent.rc /data/rtorrent.rc

VOLUME /data
VOLUME /var/www/ruTorrent-master/share

EXPOSE 80 45779-45788
