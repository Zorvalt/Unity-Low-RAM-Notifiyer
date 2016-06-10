#!/bin/bash

#Minimum available memory limit, MB
THRESHOLD=1000

#Check time interval, sec
BASE_INTERVAL=30
LOW_INTERVAL=4

while :
do
    free=$(free -m|awk '/^Mem:/{print $4}')
    cached=$(free -m|awk '/^Mem:/{print $6}')
    available=$(free -m|awk '/^Mem:/{print $7}')

    INTERVAL=$(($BASE_INTERVAL + ($available - $THRESHOLD)/100))
    MESSAGE_DURATION=$(($LOW_INTERVAL*1000 - 500))
    message="Free $free""MB, Cached $cached""MB\n------ Available $available""MB ------"

    if [ $available -lt $THRESHOLD ]
	then
        notify-send -t $MESSAGE_DURATION -u critical "Memory is running out!" "$message"
        INTERVAL=$LOW_INTERVAL
    fi

    echo $message

    sleep $INTERVAL
done
