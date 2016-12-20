#!/bin/bash
convertToMb(){
	SPACE=$1
	UNIT=$2
	if [[ $UNIT == 'Gb' ]]; then
		SPACE=`echo "$SPACE * 1000" | bc`
	elif [[ $UNIT == 'Tb' ]]; then
		SPACE=`echo "$SPACE \* 1000 \* 1000" | bc`
	elif [[ $UNIT == 'Kb' ]]; then
		SPACE=`echo "$SPACE / 1000" | bc`
	fi
    echo "$SPACE"
}
#SPACE_OLD=`/opt/nagios/libexec/check_nt -H 100.68.198.95 -p 12489 -v USEDDISKSPACE -l c | awk -F "|" '{ print $1 }'`			
SPACE_OLD=`/opt/nagios/libexec/check_nt -H $2 -p 12489 -v USEDDISKSPACE -l $4 | awk -F "|" '{ print $1 }'`
i=0
sum=0
while [[ $i -lt 30 ]]
do  
	sleep 1s
	
	UNIT_OLD=`echo "$SPACE_OLD" | awk -F " - " '{ print $2 }' | awk '{ print $3 }'`
	USED_OLD=$(convertToMb `echo "$SPACE_OLD" | awk -F " - " '{ print $3 }' | awk '{ print $2 }' | bc` $UNIT_OLD)
	
	
	SPACE_NEW=`/opt/nagios/libexec/check_nt -H $2 -p 12489 -v USEDDISKSPACE -l c | awk -F "|" '{ print $1 }'`
	UNIT_NEW=`echo "$SPACE_NEW" | awk -F " - " '{ print $2 }' | awk '{ print $3 }'`
	USED_NEW=$(convertToMb `echo "$SPACE_NEW" | awk -F " - " '{ print $3 }' | awk '{ print $2 }' | bc` $UNIT_NEW)

	
	VELOCITY=`echo "($USED_NEW-$USED_OLD)" | bc`
	
	
	sum=`echo "$sum + $VELOCITY" | bc`
	
	SPACE_OLD=$SPACE_NEW
	
	i=`expr $i + 1`
done
avg=`echo "$sum/30" | bc`
echo "VELOCITY = $avg Mb/s"

if [[ $avg -ge $8 ]]; then
	echo "CRITICAL: Drive velocity critical";
	exit 2;
elif [[ $avg -ge $6 ]]; then
	echo "WARNING: Drive velocity warning";
	exit 1;
else
	echo "OK: Drive velocity normal"
	exit 0
fi