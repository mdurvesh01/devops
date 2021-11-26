FROM jenkins/jenkins:lts
#FROM registry1.dsop.io/ironbank/solutions-delivery-platform/jenkins/jenkins@sha256:c706d46829195b40e57ad31fca7802a618e3fa5ff0d537a09843aecc248cec17

ARG USER_ID=1003
ARG USER_GID=1005
ARG DOCKER_GROUP_ID=989

USER root
RUN apt-get -y update && apt-get -y install wget
RUN apt-get -y update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN apt install iputils-ping    

RUN groupmod -g $DOCKER_GROUP_ID docker
RUN usermod -aG docker jenkins
RUN groupmod -g $USER_GID jenkins
RUN usermod -u $USER_ID -g $USER_GID jenkins
#RUN mkdir /tmp/plugins
USER jenkins
# RUN jenkins-plugin-cli --plugins blueocean:1.24.3
