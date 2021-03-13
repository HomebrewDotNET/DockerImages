# https://hub.docker.com/r/devonkupiec/pihole-unbound
FROM devonkupiec/pihole-unbound:latest

# Environment variables
ENV FORCE_CLONE=true 
ENV	SETUP_CRON=true 
ENV	UPDATE_CRON="0 1 * * */7"

RUN echo Setting up whitelisted pihole

# Pull setup script
RUN echo Pulling setup script
RUN mkdir -p /temp
ADD https://github.com/Jenssels1998/DockerImageSetup/blob/main/WhitelistedPiHole/SetupWhitelist.sh /temp
RUN apt-get update -y && apt-get install dos2unix -y
RUN chmod +x /temp/SetupWhitelist.sh && dos2unix /temp/SetupWhitelist.sh

# Run setup scripts
RUN echo Executing setup script
RUN "/temp/SetupWhitelist.sh $FORCE_CLONE $SETUP_CRON \"$UPDATE_CRON\""
RUN echo Executed setup script

# Cleanup
RUN rm -r /temp

CMD ["echo", "Done setting up whitelisted pihole"]