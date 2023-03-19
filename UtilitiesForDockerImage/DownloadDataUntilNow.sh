#!/bin/bash

LAST_DOWNLOAD_SUCCESS_TIME_FILE=last_success_time
TICKERS_FILE=tickers

START_TIME=
END_TIME=$(date +%Y%m%d-%H:%M:%S) # now

TICKERS=

DOWLOADER_PATH=.
HOME_PATH=.
while getopts p:t:h: flag
do
    case "${flag}" in
        p) DOWLOADER_PATH=${OPTARG};;
        t) TICKERS_FILE=${OPTARG};;
        h) HOME_PATH=${OPTARG};;
    esac
done

if [ ! -f $TICKERS_FILE ]
then
    echo "No Tickers File! ERROR!"
    exit -1
fi

TICKERS=$(<$TICKERS_FILE)
# echo $TICKERS

LAST_DOWNLOAD_SUCCESS_TIME_FILE=$HOME_PATH/$LAST_DOWNLOAD_SUCCESS_TIME_FILE
if [ ! -f $LAST_DOWNLOAD_SUCCESS_TIME_FILE ]
then
    START_TIME=20210101-00:00:00
    echo "No previous success file found, start from: " $START_TIME
else
    START_TIME=$(<$LAST_DOWNLOAD_SUCCESS_TIME_FILE)    
fi

# echo "Start: " $START_TIME
# echo "End: " $END_TIME
echo $DOWLOADER_PATH

RESOLUTIONS=("Minute" "Hour" "Daily")
success=true
for res in ${RESOLUTIONS[@]}; do
   echo "Start Downloading for " $res
   dotnet $DOWLOADER_PATH/QuantConnect.GDAXBrokerage.ToolBox.dll --app=download --tickers=$TICKERS --resolution=$res --from-date=$START_TIME --to-date=$END_TIME
   if [$? -ne 0]
   then
    success=false
   fi
done

echo "Success is $success"
if ["$success" == true]
then
    echo $END_TIME > $LAST_DOWNLOAD_SUCCESS_TIME_FILE
fi
