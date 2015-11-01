FROM phusion/baseimage:latest

ENV BASE_VERSION 1.0.0

# N.B. In using this image, you are accepting Oracle's license for JRE 8
# http://www.oracle.com/technetwork/java/javase/terms/license/index.html
ENV license="shared/accepted-oracle-license-v1-1" java_ver="8"

# version-bumps PPA provides libtcnative1 for Atlassian's current Tomcat builds
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -q -y git-core software-properties-common wget && \
	add-apt-repository -y ppa:webupd8team/java && \
	add-apt-repository -y ppa:predakanga/version-bumps && \
	apt-get update && echo oracle-java${java_ver}-installer ${license} select true | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive apt-get install -q -y oracle-java${java_ver}-installer oracle-java${java_ver}-set-default libtcnative-1 && \
	groupadd atlassian && \
	mkdir -p /var/lib/atlassian && \
	chgrp -R atlassian /var/lib/atlassian
