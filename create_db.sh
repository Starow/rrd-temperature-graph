#!/bin/bash

rrdtool create temperatures.rrd \
    --step 60 \
    DS:T1:GAUGE:600:-30:50 \
    DS:T2:GAUGE:600:-30:50 \
    DS:T3:GAUGE:600:-30:50 \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:12:168 \
    RRA:AVERAGE:0.5:12:720 \
    RRA:AVERAGE:0.5:288:365
