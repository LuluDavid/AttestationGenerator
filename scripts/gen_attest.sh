#!/bin/sh
SSH=ec2-user@ec2-15-188-14-163.eu-west-3.compute.amazonaws.com
shopping=$1
if [ -z "$shopping" ]
then
  shopping="False"
else
  shopping="True"
fi
a=$(ssh ${SSH} 'bash -s' -- < ssh_script.sh "$shopping")
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
