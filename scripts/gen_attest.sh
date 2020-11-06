#!/bin/sh
SSH=ec2-user@ec2-15-188-14-163.eu-west-3.compute.amazonaws.com
# Get arguments from log.json
reason=$(jq ".reason" log.json)
firstname=$(jq ".firstname" log.json)
lastname=$(jq ".lastname" log.json)
birthday=$(jq ".birthday" log.json)
placeofbirth=$(jq ".placeofbirth" log.json)
address=$(jq ".address" log.json)
city=$(jq ".city" log.json)
zipcode=$(jq ".zipcode" log.json)
# Generate the attestation through SSH
a=$(ssh ${SSH} 'bash -s' -- < ssh_script.sh "$reason" "$firstname" "$lastname" "$birthday" "$placeofbirth" "$address" "$city" "$zipcode")
ssh ${SSH} "cat ~/logs.txt; rm ~/logs.txt"
# Report and copy if it worked
if [ -z "$a" ]
then
	echo "Could not find the downloaded attestation"
else
	scp ${SSH}:~/Downloads/"$a" /Users/luciendavid/Downloads/"$a"
	ssh ${SSH} "rm ~/Downloads/$a"
	echo "Attestation $a generated"
fi
