#!/usr/bin/env bash

PROGRAM_NAME="firefox" # name of program to restart if it crashes. example: main.py
PATH_OF_PROGRAM=""
password=""

while sleep 30; do # waits for program to start after restart, thus ensure sleep (x) is long enough
  PROG_INFO=`ps -e | grep ${PROGRAM_NAME}`
  echo $PROG_INFO

  array=($PROG_INFO)

  PID=${array[0]}
  TIME=${array[2]}
  PID_NAME=${array[3]}


  echo $PID # Process Number
  echo $TIME # Time of how long the program has been active
  echo $PID_NAME #Process name according top, should be the same as $PROGRAM_NAME


  while sleep 1; do #check every (x) seconds if the program has crash

    PID_INFO=`ps -e | grep ${PROGRAM_NAME}`

    array=($PROG_INFO)

    NEW_PID=${array[0]}
    NEW_TIME=${array[2]}
    NEW_PID_NAME=${array[3]}

    if PID_NAME != NEW_PID_NAME; then #if PID's differ we will restart the app
      sudo $PATH_OF_PROGRAM/$PROGRAM_NAME &
      expect "password: "
      send "$password"
      break;
    elif TIME == TIME; then #if TIME is equal, program has hanged, and thus we must restart it
      sudo $PATH_OF_PROGRAM/$PROGRAM_NAME &
      expect "password: "
      send "$password"
      break;
    fi
  done;

done





  done
