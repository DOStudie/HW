#!/bin/bash
#Created By Yuri Groger
#Date: 29.12.2013

function usage {
   cat << EOF
Usage: hw2y.sh [-u username] [-h] [-d] 
-u username : Script will show password for this user
-h : This Help
-d : Try to decript the password with "John the Ripper"

  This script needs ROOT 
  This script shows or decrypt user password.
  For this script to run properly install "John the Ripper" from www.openwall.com/john
EOF
   exit 1
}#This func display help


if [-e "/etc/shadow"]
  then if [-r "/etc/shadow]
         then
         else
           echo "\nFile /etc/shadow : Permission denied\nPlease run this script with root permission\n"
           exit 1 
       fi 
  else
     echo "\nFile /etc/shadow does not exist" 
     exit 1
fi
#Checking if the ./etc/shadow file exist and can be read by this user



while getopts “hdt:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         d)
             TEST=$OPTARG
             ;;
         u)
             SERVER=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done


