#!/bin/bash

# This script allows you to have a dev environnement quickly

help () {
	echo "-v	Disable install of Virtual Environment"
	echo "-h	Print help"
}

virtualenv=1

while getopts "vh" o ; do
	case "${o}" in
		v)
			echo Disable virtualenv
			virtualenv=0		
			;;
		h)
			help
			exit 0
			;;
		*)
			echo "Bad usage"
			help
			exit 1
			;;
	esac
done

if [ $virtualenv -eq 1 ]; then
cmd=(
    "$sudo apt install virtualenv python3-pip"
    'virtualenv .'
    'source bin/activate'
    'python3 -m pip install Flask'
    'deactivate'
)
else
cmd=(
	'python3 -m pip install Flask'
)
fi

if [ $(whoami) != "root" ]; then
	sudo true 2>/dev/null
	if [ $? -ne 0 ]  ; then 
		echo -e "This script needs sudo or to be root, please type this command on root or relaunch it with sudo activate:\n"

		echo cd $PWD
		for x in "${cmd[@]}"
		do
    		echo $x
		done
		exit 1
	fi
	sudo="sudo"
fi

for x in "${cmd[@]}"
do
    echo $ $x
    $x ||exit 1
done

echo -e '\nInstall finished\n'

if [ $virtualenv -eq 1 ]; then	
	echo For launch Flask, do :
	echo source bin/activate
	echo flask run
	echo -e '\nTo leave virtualenv, do:'
	echo deactivate
else
	echo For launch Flask, do :
	echo python3 -m flask run
fi