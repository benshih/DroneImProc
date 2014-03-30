#!/bin/bash

echo "Initiating javascript png server"
#node node_modules/ar-drone/examples/png-stream.js &
sleep 5
echo "grabbing pngs"

a=1
while [ $a -lt 31 ]; do
    curl -s "127.0.0.1:8081" -o "${a}.png"
    echo "${a}.png"
    echo -en "\007"
    let a=a+1
    sleep 2
done
