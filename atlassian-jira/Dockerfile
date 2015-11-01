FROM predakanga/atlassian-base:latest

ENV JIRA_VERSION 7.0.0

RUN useradd --create-home --home-dir /var/lib/atlassian/jira --groups atlassian --shell /bin/bash jira && \
	mkdir -p /opt/jira && \
	wget -O /tmp/jira.tar.gz https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz && \
	tar xzf /tmp/jira.tar.gz -C /opt/jira --strip-components=1 && \
	rm -f /tmp/jira.tar.gz && \
	chown -R root:root /opt/jira && \
	chown -R jira:atlassian /opt/jira/logs /opt/jira/temp /opt/jira/work /var/lib/atlassian/jira && \
	sed -i -e '/jira.home = / c \jira.home = /var/lib/atlassian/jira' /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD service.sh /etc/service/jira/run

# 8080 is HTTP
EXPOSE 8080

VOLUME /var/lib/atlassian/jira
