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
DARKGREEN="#298A08"
YELLOW="#FFFF00"
BROWN="#8A4B08"

#####################
# LINES LEGEND NAME #
#####################
YLABEL="Temperature"
T1NAME="Living_Room"
T1AVGN="Living_Room_Avg"
T2NAME="Balcony"
T2AVGN="Balcony_Avg"
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
    LINE1:T1$DARKGREEN:$T1NAME \
    LINE1:T2$BROWN:$T2NAME \
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
    CDEF:T2A=T2,7200,TREND \
    LINE1:T1$LIME:$T1NAME \
    LINE1:T2$ORANGE:$T2NAME \
    LINE1:T3$RED:$T3NAME \
    LINE1:T1A$DARKGREEN:$T1AVGN \
    LINE1:T2A$BROWN:$T2AVGN

###########################################

rrdtool graph $IMGPATH/month.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S2W --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    CDEF:T1B=T1,$S1D,TREND \
    CDEF:T2B=T2,$S1D,TREND \
    LINE1:T1$LIME:$T1NAME \
    LINE1:T2$ORANGE:$T2NAME \
    LINE1:T3$RED:$T3NAME \
    LINE1:T1B$DARKGREEN:$T1AVGN \
    LINE1:T2B$BROWN:$T2AVGN


##########################################

rrdtool graph $IMGPATH/year.png \
    -w $WIDTH -h $HEIGHT -a PNG \
    --slope-mode \
    --start -$S2M --end now \
    --vertical-label $YLABEL \
    DEF:T1=$RRDPATH/$RRDFILE:T1:AVERAGE \
    DEF:T2=$RRDPATH/$RRDFILE:T2:AVERAGE \
    DEF:T3=$RRDPATH/$RRDFILE:T3:AVERAGE \
    CDEF:T1B=T1,$S2D,TREND \
    CDEF:T2B=T2,$S2D,TREND \
    LINE1:T1$LIME:$T1NAME \
    LINE1:T2$ORANGE:$T2NAME \
    LINE1:T3$RED:$T3NAME \
    LINE1:T1B$DARKGREEN:$T1AVGN \
    LINE1:T2B$BROWN:$T2AVGN
    #HRULE:0#00FFFF:"freezing"
