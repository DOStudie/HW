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

SHADOWFILE="/etc/shadow"
#file that conatin passwords in the system

SHADOWTMP="/tmp/shadowtmp"
#will contain all users with passwords that exist in the system

PASSWDFILE="/etc/passwd"
#contain all users settings

PASSWDTMP="/tmp/passwdtmp"
#will contain all users settings in tmp

DPASS=
#if set mean that decryption is needed

JOHNPATH=
#point to "John the Ripper" files location

USERN=
#username that need to be decrypt or shown

USERPASS=
#contain encrypted password for user

if [ ! -r $PASSWDFILE ]; then
  printf "\nFile $PASSWDFILE : Permission denied!!!!!!!\nPlease run this script with root permission\n"
  exit 1
fi
#Checking if the $SHADOWFILE file exist

if [ ! -r $SHADOWFILE ]; then
    printf "\nFile $SHADOWFILE : Permission denied!!!!!!!\nPlease run this script with root permission\n"
    exit 1
fi 
#Checking if the $SHADOWFILE file can be read by this user

cp -f $PASSWDFILE $PASSWDTMP

grep -v ":\*:" $SHADOWFILE | grep -v ":\!" > $SHADOWTMP
#Output all users with passwords to $SHADOWTMP
if (($# == 0))
  then 

  usage
  exit 1
fi

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
             if [ $USERPASS ] ;then
               printf "\nPassword for user \"$USERN\" is $USERPASS\n"
             else
               printf "\nNo password found for user \"$USERN\".\n"
	       exit 1
             fi
             ;;
         *)
             usage
             exit
             ;;
     esac
done #Going throught all flags

if [ $DPASS ]; then
  if [ ! $JOHNPATH ]; then printf "\nNo \"John the Ripper\" path specified !!!!!\n"; usage; exit 1; fi
  if [ $USERN ] && [ $USERPASS ]; then
	  if [ -e $JOHNPATH/john ]; then
		  printf "\nStarting \"JOHN THE RIPPER\" for user $USERN\n"
		  printf "$USERN:$USERPASS" > /tmp/johntmp
		  $JOHNPATH/john /tmp/johntmp
		  printf "The password is %s\n" $($JOHNPATH/john --show /tmp/johntmp | grep -w $USERN | cut -d : -f 2)
	  else
		  printf "\n\"JOHN THE RIPPER\" cannot be found in $JOHNPATH\n"
	  fi #Checks if john file exist in th folder
  else
     printf "\nNo username or password !!!!\n"
  fi #Checks if the username ans password exist
fi
#rm -y $SHADOWTMP 
