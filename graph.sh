#!/bin/bash

############
# DATABASE #
############
RRDPATH="/root/RRD"
IMGPATH="/var/www/temp-sensors/img"
RRDFILE="temperatures.rrd"

####################
# GRAPH IMAGE SIZE #
####################
HEIGHT=400
WIDTH=800

######################
# GRAPH LINES COLORS #
######################
CRIMSON="#DC143C"
CORNFLOWERBLUE="#6495ED"
BLACK="#000000"
ORANGE="#FFA500"
RED="#FF0000"
BLUE="#0000FF"
LIME="#00FF00"

#####################
# LINES LEGEND NAME #
#####################
YLABEL="Température"
T1NAME="Salon"
T1AVGN="Salon_Average"
T2NAME="20°C"
T3NAME="25°C"

###################################
# COMMON USED TIME PERIODS IN SEC #
###################################
S1D=86400
S2D=$(( $S1D * 2 ))
S4D=$(( $S2D * 2 ))
S1W=$(( $S1D * 7 ))
S2W=$(( $S1W * 2 ))
S1M=$(( $S1D * 30 ))
S2M=$(( $S1M * 2 ))
S1Y=$(( $S1D * 365 ))

###################
# GRAPHS PLOTTING #
###################
rrdtool graph $IMGPATH/day.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S2D --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    LINE1:T1$BLACK:$T1NAME \
    LINE1:T2$BLUE:$T2NAME \
    LINE1:T3$RED:$T3NAME

###########################################

rrdtool graph $IMGPATH/week.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S4D --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    CDEF:T1A=T1,7200,TREND \
    LINE1:T1$LIME:$T2NAME \
    LINE1:T2$BLUE:$T2NAME \
    LINE1:T3$RED:$T3NAME \
    LINE1:T1A$BLACK:$T1AVGN

###########################################

rrdtool graph $IMGPATH/month.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S2W --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    DEF:T4=$RRDPATH/$RRDFILE:T1:AVERAGE \
    CDEF:T1B=T1,$S1D,TREND \
    LINE1:T1$LIME:$T1NAME \
    LINE1:T2$BLUE:$T2NAME \
    LINE1:T3$RED:$T3NAME \
    LINE1:T1B$BLACK:$T1AVGN


##########################################

rrdtool graph $IMGPATH/year.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S1M --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    LINE1:T1$BLACK:$T1NAME \
    LINE1:T2$BLUE:$T2NAME \
    LINE1:T3$RED:$T3NAME
    #HRULE:0#00FFFF:"freezing"
