FROM predakanga/atlassian-base:latest

ENV BITBUCKET_VERSION 4.0.2

# NB: Installation documents don't require that logs are owned by bitbucket, but startup scripts do
# NB: setenv.sh could also be overridden using environment variables, but we're following the docs
RUN useradd --create-home --home-dir /var/lib/atlassian/bitbucket --groups atlassian --shell /bin/bash bitbucket && \
	mkdir -p /opt/bitbucket && \
	wget -O /tmp/bitbucket.tar.gz https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BITBUCKET_VERSION}.tar.gz && \
	tar xzf /tmp/bitbucket.tar.gz -C /opt/bitbucket --strip-components=1 && \
	rm -f /tmp/bitbucket.tar.gz && \
	sed -i -e 's:export BITBUCKET_HOME=$:BITBUCKET_HOME=/var/lib/atlassian/bitbucket:' \
	       -e '/^JVM_LIBRARY_PATH=/ a \JVM_LIBRARY_PATH="${JVM_LIBRARY_PATH}:/usr/lib/x86_64-linux-gnu"' \
	       /opt/bitbucket/bin/setenv.sh && \
	chown -R root:root /opt/bitbucket && \
	chown -R bitbucket:atlassian /opt/bitbucket/logs /opt/bitbucket/temp /opt/bitbucket/work /var/lib/atlassian/bitbucket && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*	

ADD service.sh /etc/service/bitbucket/run

# 7990 is HTTP
# 7999 is SSH
EXPOSE 7990 7999

VOLUME /var/lib/atlassian/bitbucket
