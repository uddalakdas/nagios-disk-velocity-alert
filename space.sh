#!/bin/bash

SPACE=`/opt/nagios/libexec/check_nt -H $2 -p 12489 -v USEDDISKSPACE -l $4 | awk -F "|" '{ print $1 }'`
FREE=`echo "$SPACE" | awk -F " - " '{ print $4 }' | awk '{ print $2 }'`
TOTAL=`echo "$SPACE" | awk -F " - " '{ print $2 }' | awk '{ print $2 }'`
PERCENT=`echo "($FREE*100)/$TOTAL" | bc`
echo "SPACE FREE = $PERCENT%"
if [[ $PERCENT -le $8 ]]; then
	echo "CRITICAL: Drive space critical"
	exit 2
elif [[ $PERCENT -le $6 ]]; then
	echo "WARNING: Drive space warning"
	exit 1
else
	echo "OK: Drive space normal"
	exit 0
fi