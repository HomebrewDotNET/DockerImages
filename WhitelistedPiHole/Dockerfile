FROM pihole/pihole:latest

# Environment variables
ENV UPDATE_REFERRAL=false
ENV	UPDATE_CRON="0 6 * * */7"

USER root

# Install Python3
RUN echo Installing Python3
RUN  apt-get update -y \
  && apt-get install -y python3 
RUN echo Installed Python3

COPY entrypoint.sh /app/whitelisted_pihole/entrypoint.sh
COPY update_whitelist.sh /app/whitelisted_pihole/update_whitelist.sh
RUN chmod +x /app/whitelisted_pihole/entrypoint.sh
RUN chmod +x /app/whitelisted_pihole/update_whitelist.sh

ENTRYPOINT ["/app/whitelisted_pihole/entrypoint.sh"]

USER pihole