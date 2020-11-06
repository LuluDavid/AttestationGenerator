#!/bin/sh
# Set up ssh
SSH=ec2-user@ec2-15-188-14-163.eu-west-3.compute.amazonaws.com
eval "$(ssh-agent -s)"
if [ ! -f "Test.pem" ]
then
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
a=$(ssh ${SSH} 'bash -s' -- < ssh_script.sh "$reason" "$firstname" "$lastname" "$birthday" "$placeofbirth" "$address" "$city" "$zipcode")
ssh ${SSH} "cat ~/logs.txt; rm ~/logs.txt"
# Report and copy if it worked
if [ -z "$a" ]
then
	echo "Could not find the downloaded attestation"
else
	scp ${SSH}:~/Downloads/"$a" ~/Downloads/"$a"
	ssh ${SSH} "rm ~/Downloads/$a"
	echo "Attestation $a generated"
fi
