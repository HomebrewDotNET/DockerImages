FROM jenkins/jenkins:latest

ARG Entrypoint_FileName=

USER root

WORKDIR /

# Environment variables
ENV INSTALL_NETSDK=true 
ENV INSTALL_NUGET=true 
ENV INSTALL_DOCKER=false 
ENV SET_MULTI_ARCH_BUILDER=false 
ENV MULTI_ARCH_BUILDER_NODE_NAME="Jenkins.Net-Builder"

# Install Wget
RUN echo Installing wget
RUN  apt-get update -y \
  && apt-get install -y wget 
RUN echo Installed wget

COPY entrypoint.sh /app/jenkins_net/entrypoint.sh
RUN chmod +x /app/jenkins_net/entrypoint.sh

ENTRYPOINT ["/app/jenkins_net/entrypoint.sh"]

USER jenkins

