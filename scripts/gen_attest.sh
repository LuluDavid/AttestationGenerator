#!/bin/sh
SSH=ec2-user@ec2-15-188-14-163.eu-west-3.compute.amazonaws.com
a=$(ssh ${SSH} 'bash -s' < ssh_script.sh)
# Report and copy if it worked
if [ -z "$a" ]
then
	echo "Could not find the downloaded attestation"
else
	echo "Attestation $a generated"
	scp ${SSH}:~/Downloads/"$a" /Users/luciendavid/Downloads/"$a"
	ssh ${SSH} "rm ~/Downloads/$a"
fi
