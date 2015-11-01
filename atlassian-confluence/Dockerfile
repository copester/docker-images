FROM predakanga/atlassian-base:latest

ENV CONFLUENCE_VERSION 5.8.9

RUN useradd --create-home --home-dir /var/lib/atlassian/confluence --groups atlassian --shell /bin/bash confluence && \
	mkdir -p /opt/confluence && \
	wget -O /tmp/confluence.tar.gz https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz && \
	tar xzf /tmp/confluence.tar.gz -C /opt/confluence --strip-components=1 && \
	rm -f /tmp/confluence.tar.gz && \
	chown -R root:root /opt/confluence && \
	chown -R confluence:atlassian /opt/confluence/logs /opt/confluence/temp /opt/confluence/work /var/lib/atlassian/confluence && \
	sed -i -e '$ a \confluence.home=/var/lib/atlassian/confluence' /opt/confluence/confluence/WEB-INF/classes/confluence-init.properties && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD service.sh /etc/service/confluence/run

# 8090 is HTTP
EXPOSE 8090

VOLUME /var/lib/atlassian/confluence
