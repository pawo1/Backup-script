#!/bin/bash

#Rsync backups for your VPS by Pawo
#Requirements: zip, rsync

KEEP_FOR=7 #number of days to keep backup file
PORT=22 #port to ssh 

COLOR_BLUE_LIGHT="\033[1;34m"
COLOR_ORANGE="\033[0;33m"
COLOR_YELLOW="\033[1;33m"
COLOR_GRAY="\033[1;30m"
COLOR_END="\033[0m"

stars="***********************************************************************"

case $# in
	2) 
	mkdir $2/temp
	rsync -a $1 $2/temp ;;
	3)
	mkdir $2/temp
	rsync -a -e "ssh -p $PORT -i $3" $1 $2/temp ;;
	*)
	echo -e "${COLOR_GRAY}$stars"
	echo -e "*                       ${COLOR_BLUE_LIGHT}Backup script by Pawo${COLOR_END}                         ${COLOR_GRAY}*"
	echo -e "$stars"
	echo -e "* ${COLOR_YELLOW}Local:${COLOR_END} ./backup.sh SOURCE_PATH DESTINATION_PATH                     ${COLOR_GRAY}*"
	echo -e "* ${COLOR_ORANGE}Remote:${COLOR_END} ./backup.sh USER@HOST:SOURCE_PATH DESTINATION_PATH KEY_PATH ${COLOR_GRAY}*"
	echo -e "$stars"
	echo -e "*        ${COLOR_END}You can change SSH PORT and Storage date by editing ${COLOR_GRAY}         *"
 	echo -e "*              ${COLOR_END}variables at the beginning of the script${COLOR_GRAY}               *"
	echo -e "$stars${COLOR_END}"
	exit
esac

shopt -s nullglob
files=(*.zip)

if (( ${#files[@]} > $KEEP_FOR )); then
	old=$(ls *.zip -Ar | tail -1)
	rm $old
fi

NAME=$(date +"%Y-%m-%d")

cd $2/temp
zip -r ../$NAME.zip *
cd ..

rm -r $2/temp
