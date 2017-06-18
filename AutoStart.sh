#!/usr/bin/env bash

PROGRAM_NAME="firefox" # name of program to restart if it crashes. example: main.py
PATH_OF_PROGRAM=""
password=""

while sleep 1; do # waits for program to start after restart, thus ensure sleep (x) is long enough
  PROG_INFO=`ps -e | grep ${PROGRAM_NAME}`
  echo $PID_INFO

  array=($PROG_INFO)

  PID=${array[0]}
  TIME=${array[2]}
  PID_NAME=${array[3]}


  echo "PID: " $PID # Process Number
  echo "TIME: " $TIME # Time of how long the program has been active
  echo "PID_NAME: " $PID_NAME #Process name according top, should be the same as $PROGRAM_NAME



  export PID
  export TIME

  { while sleep 1; do #check every (x) seconds if the program has crash
    echo "in Checker Loop"
    echo $PROGRAM_NAME
    PID_INFO=`ps -e | grep ${PROGRAM_NAME}`

    array=($PID_INFO)

    NEW_PID=${array[0]}
    NEW_TIME=${array[2]}
    NEW_PID_NAME=${array[3]}

    echo "NEW_PID: " $NEW_PID
    echo "PID: " $PID
    sleep 2

    echo "TIME: " $TIME
    echo "NEW_TIME: " $NEW_TIME


    if [ "$PID" != "$NEW_PID" ]; then #if PID's differ we will restart the app
      echo "PID HAS CHANGED"
      # sudo $PATH_OF_PROGRAM/$PROGRAM_NAME &
      # expect "password: "
      # send "$password"
      break
    elif [ $TIME == $NEW_TIME ]; then #if TIME is equal, program has hanged, and thus we must restart it
      echo "TIME IS CONSTANT"
      # sudo $PATH_OF_PROGRAM/$PROGRAM_NAME &
      # expect "password: "
      # send "$password"
      # break
    fi
    echo "sleeping"
    sleep 1
  done }

done





  done
