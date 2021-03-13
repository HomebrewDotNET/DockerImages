#!/bin/bash
set -x
echo "Setup script for whitelisted pihole image executing"

# Setup constants
WhitelistDir="/opt/whitelist"
GitDir=".git"
WhitelistGitDir="$WhitelistDir/$GitDir"
WhitelistScript="$WhitelistDir/scripts/whitelist.py"

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
python3 $WhitelistScript

echo "Installed whitelist"

if [ "$SetupCron" = true ]; then
	echo "Setting up update cron"
	(crontab -u root -l; echo "$UpdateCron root $WhitelistScript" ) | crontab -u root -
fi