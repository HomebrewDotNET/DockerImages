#!/bin/bash

# Constants
CronDir="/etc/cron.d"
CronFile="$CronDir/pihole_whitelist_update"
CronLog="/var/log/pihole_whitelist_update.log"
UpdateScript="/app/whitelisted_pihole/update_whitelist.sh"

# Start
echo "[$(date)] Setting up Whitelisted PiHole"

echo "[$(date)] Calling update script"
/bin/bash $UpdateScript
echo "[$(date)] Called update script"

if [[ -n $UPDATE_CRON ]]; then
	echo "[$(date)] Setting up automatic whitelist update using cron $UPDATE_CRON"
	
	touch $CronFile
	touch $CronLog
	echo "$UPDATE_CRON root $UpdateScript >> $CronLog" > $CronFile
	crontab $CronFile
	
	echo "[$(date)] Enabled automatic whitelist update"
fi

echo "[$(date)] Finished setting up Whitelisted PiHole. Calling pihole entrypoint script"
/bin/bash /s6-init

exit