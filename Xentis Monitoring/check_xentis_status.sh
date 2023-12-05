#!/bin/bash
#---------------------------------------------------------------------------------------------------
check_date()
{
file2check=$1
not_older_than=$2

if [ ! -e $file2check ]; then echo "status file missing"; exit; fi


# Get current and file times
current_time=$(date +%s)
lastmod_filetime=$(stat $file2check -c %Y)
timediff=$(expr $current_time - $lastmod_filetime)

if [ $timediff -gt $not_older_than ]; then echo "file too old"; exit; fi

}
#---------------------------------------------------------------------------------------------------
BASEDIR=$(dirname "$0")
cd "$BASEDIR"
. ./check_xentis_status.sh.config
#
return_string=""
xentis_status_file="./xentis.status"
#
check_date $xentis_status_file 600 # file older than 10 minutes
#
for single_status in $status_list
do
    defined_status=`echo $single_status | cut -d'/' -f2`
    XENTIS_service=`echo $single_status | cut -d'/' -f1`
    #
    current_status=`grep "+ ${XENTIS_service}" $xentis_status_file | cut -d":" -f2 | tr '[:lower:]' '[:upper:]'`
    #
    current_status=`echo "$current_status" | tr -d ' '`
    #
    if [ "$current_status" != "$defined_status" ]; then return_string+="$XENTIS_service,"; fi
done
if [ ! -z "$return_string" ];
then
  return_string=`echo ${return_string} | sed 's/.$//'`
  return_string+=" bad"
else
  return_string="AllGood"
fi
#echo "$oid"
#echo "STRING"
echo $return_string
