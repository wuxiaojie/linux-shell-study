#! /bin/bash

KEYS="retry_check_interval:retry_interval      ,normal_check_interval:check_interval       "

while getopts :f:d:k: opt
do
  case $opt in
   f) FILES=$OPTARG
      ;;
   d) DIRS=$OPTARG
      ;;
   k) KEYS=$OPTARG
      ;;
   '?')
      echo -e "$0: invalid option -$OPTARG" >&2
      help_info
      exit 1
  esac
done

function help_info(){
  echo "$0 is used to update some nagios configuration to fix some warnings" 
  echo "-f configuration files to update"
  echo "-d directories to update"
  echo "-k keys to update, the formal should be 'key1:newkey2,key2:newkey2', where only COMMA can be accepted!!!"
}


function file_update(){
   key_array=("$1")
#   echo ${key_array[*]} 
   file=$2
   for key_pair in ${key_array[*]}
   do
        key=$(echo "${key_pair}" | cut -f1 -d':')
        nkey=$(echo "${key_pair}" | cut -f2 -d':')
#        echo "$key" | wc -c
#        echo "$nkey" | wc -c 
        /usr/bin/sed -i "s@${key}@${nkey}@g" "${file}"
   done
}

OLD_IFS="$IFS"
IFS=","
key_array=($KEYS)
IFS="$OLD_IFS"

OLD_IFS="$IFS"
IFS=", "
dir_array=($DIRS)
file_array=($FILES)
IFS="$OLD_IFS"

#echo ${key_array[*]} 

if [[ -z "${dir_array[0]}" && -z "${file_array[0]}" ]]
then
   echo "file or directory should be offered"
   help_info
   exit 2
fi

if [ -n "${dir_array[0]}" ]
then
  for dir in ${dir_array[*]}
  do
    for file in $(/bin/ls "$dir"| grep -v total | cut -f2 -d' ')
    do
       OLD_IFS="$IFS"
       IFS=","
       file_update "${key_array[*]}" "${dir}/${file}"
       IFS="$OLD_IFS"
    done
  done
fi

if [ -n "${file_array[0]}" ]
then
   for file in ${file_array[*]}
   do
       OLD_IFS="$IFS"
       IFS=","
       file_update "${key_array[*]}" ${file}
       IFS="$OLD_IFS"
   done
fi
IFS=", "
dir_array=($DIRS)
file_array=($FILES)
IFS="$OLD_IFS"

#echo ${key_array[*]} 

if [[ -z "${dir_array[0]}" && -z "${file_array[0]}" ]]
then
   echo "file or directory should be offered"
   help_info
   exit 2
fi

if [ -n "${dir_array[0]}" ]
then
  for dir in ${dir_array[*]}
  do
    for file in $(/bin/ls "$dir"| grep -v total | cut -f2 -d' ')
    do
