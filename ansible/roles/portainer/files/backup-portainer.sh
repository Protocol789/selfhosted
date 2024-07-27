#!/bin/bash

####### Backs up the local portainer system to specified folder 

# Set variables from arguments passed in postions 1-2
apikey=$1
hostname=$2
backup_location=$3

## Get the current date and time
current_datetime=$(date '+%Y-%m-%d_%H-%M-%S')

# Construct the file name
file_name="portainer-$hostname-$current_datetime.tar.gz"

# Make call to local portainer api to grab a backup and store it in the backup folder
# --fail-with-body pushes up an non 0 exit code if it fails on getting the data from the API
curl --fail-with-body -k "https://localhost:9443/api/backup" \
-H "x-api-key: $apikey" \
-H 'Content-Type: application/json; charset=utf-8' \
-d '{ "password": "" }' --output "$backup_location/$file_name"

# Check the integrity of tar file. Non zero exit code indicates an error
tar -tvvf $file_name &> /dev/null
