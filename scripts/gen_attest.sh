#!/bin/sh
# Set up ssh
SSH=ec2-user@ec2-35-180-192-110.eu-west-3.compute.amazonaws.com
if [ -f "Test.pem" ]
then
  eval "$(ssh-agent -s)"
  ssh-add "Test.pem"
fi
# Get logfile
logfile=$1
# Get arguments from log.json
reason=$(jq ".reason" "$logfile")
firstname=$(jq ".firstname" "$logfile")
lastname=$(jq ".lastname" "$logfile")
birthday=$(jq ".birthday" "$logfile")
placeofbirth=$(jq ".placeofbirth" "$logfile")
address=$(jq ".address" "$logfile")
city=$(jq ".city" "$logfile")
zipcode=$(jq ".zipcode" "$logfile")
# Generate the attestation through SSH
a=$(ssh ${SSH} 'bash -s' -- < ~/AttestationGenerator/scripts/ssh_script.sh "$reason" "$firstname" "$lastname" "$birthday" "$placeofbirth" "$address" "$city" "$zipcode")
ssh ${SSH} "cat ~/logs.txt; rm ~/logs.txt"
# Report and copy if it worked
if [ -z "$a" ]
then
	echo "Could not find the downloaded attestation"
else
	scp ${SSH}:~/Downloads/"$a" ~/storage/shared/Download/"$a"
	ssh ${SSH} "rm ~/Downloads/$a"
	echo "Attestation $a generated"
fi
