#!/bin/bash

if [ $# -eq 0 ]
then
    PORT=8082
    echo "Grabbing PNG from default port 8082"
elif [ $# -eq 1 ]
then
    PORT=$1
    echo "Grabbing PNG from port ${1}"
fi

echo "Initiating javascript png server"
node simple_flight.js &
echo "grabbing pngs"

sleep 5
a=1
while [ $a -lt 45 ]; do
    curl "127.0.0.1:${PORT}" -o "${a}.png"
    echo "${a}.png"
    let a=a+1
    sleep 0.5
done
