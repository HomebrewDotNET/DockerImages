FROM jenkins/jenkins:latest

USER root

WORKDIR /tmp

# Install wget
RUN echo Installing wget
RUN  apt-get update -y \
  && apt-get install -y wget 
RUN echo Installed wget

# Add Microsoft package key
RUN echo Adding Microsoft package key
RUN wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm -v packages-microsoft-prod.deb
RUN echo Added Microsoft package key

# Install .NET Sdk
RUN echo Installing .NET Sdk package
RUN apt-get update -y && \
	apt-get install -y apt-transport-https && \
	apt-get update -y && \
	apt-get install -y dotnet-sdk-5.0
	
# Install NuGet
RUN echo Installing NuGet
RUN  apt-get update -y \
  && apt-get install -y nuget 
RUN echo Installed NuGet

# Install Docker
RUN echo Adding Docker repository
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN echo Added Docker repository

RUN echo Installing Docker
RUN  apt-get update -y \
  && apt-get install -y docker-ce docker-ce-cli
RUN echo Installed Docker

WORKDIR /
