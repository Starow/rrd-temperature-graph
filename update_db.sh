#!/bin/bash

SENSOR_PATH="/sys/bus/w1/devices/28-000006157725/w1_slave"
DB_PATH="/root/RRD"
DB_NAME="temperatures.rrd"

T1=$(awk -F "t=" '{$0=$2}1' $SENSOR_PATH)

T1=${T1:1:5}
T1=$(echo "scale=2; $T1/1000" | bc)

T2=20
T3=25

rrdtool update $DB_PATH/$DB_NAME N:$T1:$T2:$T3
