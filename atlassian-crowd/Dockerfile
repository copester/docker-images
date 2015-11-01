FROM predakanga/atlassian-base:latest

ENV CROWD_VERSION 2.8.3

RUN useradd --create-home --home-dir /var/lib/atlassian/crowd --groups atlassian --shell /bin/bash crowd && \
	mkdir -p /opt/crowd && \
	wget -O /tmp/crowd.tar.gz https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-${CROWD_VERSION}.tar.gz && \
	tar xzf /tmp/crowd.tar.gz -C /opt/crowd --strip-components=1 && \
	rm -f /tmp/crowd.tar.gz && \
	chown -R root:root /opt/crowd && \
	chown -R crowd:atlassian /opt/crowd/apache-tomcat/logs /opt/crowd/apache-tomcat/temp /opt/crowd/apache-tomcat/work /var/lib/atlassian/crowd && \
	chmod a+X /opt/crowd/*.sh /opt/crowd/apache-tomcat/bin/*.sh && \
	mkdir /opt/crowd/database && \
	touch /opt/crowd/atlassian-crowd-openid-server.log && \
	chown -R crowd:atlassian /opt/crowd/database /opt/crowd/atlassian-crowd-openid-server.log && \
	sed -i -e '$ a \crowd.home=/var/lib/atlassian/crowd' /opt/crowd/crowd-webapp/WEB-INF/classes/crowd-init.properties && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove the context path and disable the sample apps - for clarity's sake, this is done as a separate step
# NB: build.sh uses $PWD - have to cd to /opt/crowd
ADD crowd-webapp.xml /tmp/crowd-webapp.xml
RUN sed -i -e '/crowd.url=/ c \crowd.url=http://localhost:8095' /opt/crowd/build.properties && \
	cd /opt/crowd && \
	./build.sh && \
	rm -rf /opt/crowd/apache-tomcat/webapps/ROOT && \
	sed -i -e '/<Engine / r /tmp/crowd-webapp.xml' \
		   -e '/<Host / d' \
		   /opt/crowd/apache-tomcat/conf/server.xml && \
	rm -f /tmp/crowd-webapp.xml && \
	rm -f /opt/crowd/apache-tomcat/conf/Catalina/localhost/*.xml

ADD service.sh /etc/service/crowd/run

# 8095 is HTTP
EXPOSE 8095

VOLUME /var/lib/atlassian/crowd
