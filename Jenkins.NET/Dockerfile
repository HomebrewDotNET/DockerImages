# For pulling SDK install scripts
FROM ubuntu:latest as Initializer
WORKDIR /source

# Install wget
RUN echo Installing wget
RUN  apt-get update -y \
  && apt-get install -y wget 
RUN echo Installed wget

# Pull official .NET install script
RUN echo Pulling .NET SDK install script
RUN wget https://dot.net/v1/dotnet-install.sh
RUN chmod +x dotnet-install.sh
RUN echo Pulled .NET SDK install script

#Final image
FROM jenkins/jenkins:lts-jdk11

#Copy install scripts
RUN echo Copying install script
WORKDIR /tmp
COPY --chown=root:root --from=Initializer /source/dotnet-install.sh /tmp/dotnet-install.sh
RUN echo Copied install script

# Install .NET SDK using pulled script
RUN echo Installing SDK using install script
RUN ./dotnet-install.sh -c 5.0
RUN echo Installed .NET SDK

WORKDIR /
