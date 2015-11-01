FROM predakanga/atlassian-base:latest

ENV BAMBOO_VERSION 5.9.7

# NB: Docs say we need write on /opt/bamboo/*; loosen restrictions if problems appear
RUN useradd --create-home --home-dir /var/lib/atlassian/bamboo --groups atlassian --shell /bin/bash bamboo && \
    mkdir -p /opt/bamboo && \
    wget -O /tmp/bamboo.tar.gz https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz && \
    tar xzf /tmp/bamboo.tar.gz -C /opt/bamboo --strip-components=1 && \
    rm -f /tmp/bamboo.tar.gz && \
    chown -R root:root /opt/bamboo && \
    chown -R bamboo:atlassian /opt/bamboo/logs /opt/bamboo/temp /opt/bamboo/work /var/lib/atlassian/bamboo && \
	sed -i -e '$ a \bamboo.home=/var/lib/atlassian/bamboo' /opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD service.sh /etc/service/bamboo/run

# 8085  is HTTP
# 54663 is agent endpoint
EXPOSE 8085 54663

VOLUME /var/lib/atlassian/bamboo
