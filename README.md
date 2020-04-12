# Backup-script

Simple script which uses rsync to store data from a remote server

## Requirments 
zip and rsync

## Syntax

### Local:
`./backup.sh SOURCE_PATH DESTINATION_PATH`
### Remote:
`./backup.sh USER@HOST:SOURCE_PATH DESTINATION_PATH KEY_PATH`

Default SSH Port is 22, if you need different port edit `PORT` variable at the beginning of script. You also can edit
'KEEP_FOR' variable to manage how many backup-files do you want to keep

## Automation
To make this script working daily add following line to crontab by `crontab -e`
`0 2 * * * PATH_TO_SCRIPT/backup.sh ARGUMENTS`
(the script will run every day at 2am)
