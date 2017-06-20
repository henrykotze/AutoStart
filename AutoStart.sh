#!/usr/bin/env bash


PROGRAM_NAME="playground.py" # name of program to restart if it crashes. example: main.py

PATH_OF_PROGRAM="/home/henry/Desktop/ssiotRev2_playground"
password=""
COMMAND_NAME="${PATH_OF_PROGRAM}/${PROGRAM_NAME}" # command which we will be searching for in the processes


# This sleep number indictates the total number of seconds before the app will start after a boot of the system, if this program is set to start after boot
while sleep 1; do # waits for program to start after restart, thus ensure sleep (x) is long enough

  python $COMMAND_NAME &  # start the app
  # expect "password: "   #This is only necessary if your program requests to be root user and ask for the password
  # send $password

  sleep 2;  #we give sufficient amount of time for the program to launch, so that it will be indicated in the processes list

  PROG_INFO=`ps aux | grep ${COMMAND_NAME}` # Retrieves all the infomations regarding the programs processes
  echo "PID_INFO: " $PROG_INFO

  array=($PROG_INFO)

  PID=${array[1]}         #PID of the program
  START_TIME=${array[8]}  #Time at which the program was started
  TOTAL_TIME=${array[9]}  #Total time which the program has been running


  echo "PID: " $PID # Process Number
  echo "START_TIME: " $START_TIME # Time of how long the program has been active
  echo "TOTAL_TIME: " $TOTAL_TIME #Process name according top, should be the same as $PROGRAM_NAME



  export PID    #Gives access to the subshell when we are in the while loop
  export TOTAL_TIME   #Gives access to the subshell when we are in the while loop

  { while sleep 5; do #check every (x) seconds if the program has crash
    echo "CHECKING CHANCES. . . ."
    PID_INFO=`ps aux | grep ${COMMAND_NAME}`  #Find the information about the processes of the program

    array=($PID_INFO)

    NEW_PID=${array[1]}
    NEW_START_TIME=${array[2]}
    NEW_TOTAL_TIME=${array[9]}

    echo "NEW_PID: " $NEW_PID
    echo "PID: " $PID
    sleep 2                     #This can be removed if the sleep value above is long enough

    echo "TOTAL_TIME: " $NEW_TOTAL_TIME

    if [ "$PID" != "$NEW_PID" ]; then #if PID's differ, the program has crashed and  we will restart the app
      echo "PID HAS CHANGED"
      kill -KILL $PID
      # expect "password: "   #This is only necessary if your program requests to be root user and ask for the password
      # send $password
      break
    elif [ $TOTAL_TIME == $NEW_TOTAL_TIME ]; then #if TIME is equal, program has hanged, and thus we must restart it
      echo "TIME IS CONSTANT"
      kill -KILL $PID
      # expect "password: "   #This is only necessary if your program requests to be root user and ask for the password
      # send $password
      break
    fi
    TOTAL_TIME=$NEW_TOTAL_TIME
    echo "sleeping"
    # sleep 5
  done }

done
