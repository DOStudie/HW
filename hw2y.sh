#!/bin/bash

#Created By Yuri Groger
#Date: 29.12.2013

function usage {
cat << EOF

Usage: hw2y.sh [-u username] [-d] [-a] [-j path_to_files] [-h] 
-u username : Script will show password for this user
-h : This Help
-d : Try to decript the password with "John the Ripper"
-j john_path : Path to where John The Ripper located
-a : Show all users with passwords

  This script needs ROOT 
  This script shows or decrypt user password.
  For this script to run properly install "John the Ripper" from www.openwall.com/john

EOF
exit 1
}
#Display help

PASSFILE="/etc/shadow"
#file that conatin passwords in the system

SHADOWTMP="/tmp/shadowtmp"
#will contain all users with passwords that exist in the system


DPASS=
#if set mean that decryption is needed

JOHNPATH=
#point to "John the Ripper" files location

USERN=
#username that need to be decrypt or shown

USERPASS=
#contain encrypted password for user

if [ ! -f $PASSFILE ]; then
  printf "\nFile $PASSFILE does not exist"
  exit 1
fi
#Checking if the $PASSFILE file exist

if [ ! -r $PASSFILE ]; then
    printf "\nFile $PASSFILE : Permission denied!!!!!!!\nPlease run this script with root permission"
    exit 1
fi 
#Checking if the $PASSFILE file can be read by this user

grep -v ":\*:" $PASSFILE | grep -v ":\!" > $SHADOWTMP
#Output all users with passwords to $SHADOWTMP

while getopts "ahdu:j:" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         a)
             printf "\nAll users with passwords:\n"
             cat $SHADOWTMP
             ;;
         j)
             JOHNPATH=$OPTARG
             ;;
         d)
             DPASS=1
             ;;
         u)
             USERN=$OPTARG
             USERPASS=$(grep -w $USERN $SHADOWTMP | cut -d : -f 2)
             if [ $USERPASS] ;then
               printf "\nPassword for user \"$USERN\" is $USERPASS\n"
             else
               printf "\nNo password found for user \"$USERN\".\n"
             fi
             ;;
         *)
             usage
             exit
             ;;
     esac
done

if [ $DPASS ]; then
  if [ ! $JOHNPATH ]; then printf "\nNo \"John the Ripper\" path specified !!!!!\n"; usage; exit 1; fi
  if [ $USERN ] && [ $USERPASS ]; then
     printf "\nGO GO GO GO GO GO\n"
  else
     printf "\nNo username or password !!!!\n"
  fi
fi
#rm -y $SHADOWTMP 
