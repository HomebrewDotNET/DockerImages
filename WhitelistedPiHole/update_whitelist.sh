#!/bin/bash

# Setup constants
TempDir="/tmp/whitelist_update"
ScriptDir="$TempDir/whitelist/scripts"
WhitelistScript="$ScriptDir/whitelist.py"
ReferralScript="$ScriptDir/referral.sh"
GitRepo="https://github.com/anudeepND/whitelist.git"

#Start
echo "[$(date)] Updating whitelist for pihole"

mkdir -p $TempDir

echo "[$(date)] Pulling latest whitelist scripts"
git clone $GitRepo $TempDir

echo "[$(date)] Pulled latest whitelist scripts. Updating now"
python3 $WhitelistScript --docker


if [ ! -z $UPDATE_REFERRAL ]; then
	echo "[$(date)] Updating white using referral list"
	/bin/bash $ReferralScript --docker
fi

echo "[$(date)] Cleaning up"
rm -Rfv $TempDir

echo "[$(date)] Updated whitelist for pihole"