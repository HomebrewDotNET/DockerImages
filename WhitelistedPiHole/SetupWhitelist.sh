#!/bin/bash
echo "Setup script for whitelisted pihole image executing"

# Setup constants
WhitelistDir="/opt/whitelist"
GitDir=".git"
WhitelistGitDir="$WhitelistDir/$GitDir"
WhitelistScript="$WhitelistDir/scripts/whitelist.py"
CronDir="/etc/cron.d"
CronBootFile="$CronDir/WhitelistBoot"
CronFile="$CronDir/WhitelistUpdate"
CronBootLog="/var/log/WhitelistBoot.log"
CronLog="/var/log/WhitelistUpdate.log"

#Setup variables
ForceClone=false
SetupCron=false
UpdateCron="0 1 * * */7"

# Parse arguments
if [ ! -z $1 ]; then
   ForceClone=$1
fi

if [ ! -z $2 ]; then
   SetupCron=$2
fi

if [ ! -z $3 ]; then
   UpdateCron=$3
fi

# Install python3
echo "Installing python3"

apt-get update -y && apt-get install python3 -y

echo "Installed python3"

# Setup working dir for whitelist
echo "Setting up working dir for whitelist"
mkdir -p $WhitelistDir
cd $WhitelistDir

# Clone repo if it doesn't exists already or forcepull is enabled
if [ -d "$WhitelistGitDir" ] || [ "$ForceClone" = true ]; then
  echo "Pulling whitelist repository"
  git clone https://github.com/anudeepND/whitelist.git .
else
  echo "$WhitelistGitDir exists so not pulling"
fi

echo "Working dir setup for whitelist"

# Install whitelist
echo "Installing whitelist"
# Run whitelist script on reboot. 
mkdir -p $CronDir
touch $CronBootFile
echo "@reboot root sleep 120 && $WhitelistScript >$CronBootLog" > $CronBootFile
touch $CronBootLog
crontab $CronBootFile

python3 $WhitelistScript --docker
echo "Installed whitelist"

if [ "$SetupCron" = true ]; then
	echo "Setting up update cron"	
	touch $CronFile
	echo "$UpdateCron root $WhitelistScript >$CronLog" > $CronFile
	touch $CronLog
	crontab $CronFile
fi