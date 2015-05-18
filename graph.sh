#!/bin/bash

RRDPATH="/root/RRD"
IMGPATH="/var/www/temp-sensors/img"
RRDFILE="temperatures.rrd"

T1COLOR="#2E9AFE"
T1COAVG="#000000"

T2COLOR="#000FFF"
T3COLOR="#FF0000"

T1NAME="Salon"
T1AVGN="Salon_Average"

T2NAME="20°C"
T3NAME="25°C"

rrdtool graph $IMGPATH/day.png \
    -w 800 -h 400 -a PNG \
    --slope-mode \
    --start -172800 --end now \
    --vertical-label "temperature (°C)" \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    LINE1:T1$T1COLOR:$T1NAME \
    LINE1:T2$T2COLOR:$T2NAME \
    LINE1:T3$T3COLOR:$T3NAME

###########################################

rrdtool graph $IMGPATH/week.png \
-w 800 -h 400 -a PNG \
--slope-mode \
--start -345600 --end now \
--vertical-label "temperature (°C)" \
DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
CDEF:T1A=T1,7200,TREND \
LINE1:T2$T2COLOR:$T2NAME \
LINE1:T3$T3COLOR:$T3NAME \
LINE1:T1A$T1COAVG:$T1AVGN

###########################################

rrdtool graph $IMGPATH/month.png \
-w 800 -h 400 -a PNG \
--slope-mode \
--start -2629743 --end now \
--vertical-label "temperature (°C)" \
DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
DEF:T4=$RRDPATH/$RRDFILE:T1:AVERAGE \
CDEF:T1B=T1,86400,TREND \
LINE1:T1$T1COLOR:$T1NAME \
LINE1:T2$T2COLOR:$T2NAME \
LINE1:T3$T3COLOR:$T3NAME \
LINE1:T1B$T1COAVG:$T1AVGN


##########################################

rrdtool graph $IMGPATH/year.png \
-w 800 -h 400 -a PNG \
--slope-mode \
--start -31536000 --end now \
--vertical-label "temperature (°C)" \
DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
LINE1:T1$T1COLOR:$T1NAME \
LINE1:T2$T2COLOR:$T2NAME \
LINE1:T3$T3COLOR:$T3NAME
#HRULE:0#00FFFF:"freezing"
