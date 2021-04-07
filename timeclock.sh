#!/bin/bash
clear
######################################
# Author: Megan West
# Course: ITSC 1305 Spring 2021
# Instructor: Prof Onabajo
# Title: Time Clock
# Purpose:
# 1. gets the time in, lunch out, lunch in, time out from user
# 2. converts the times to minutes past midnight
# 3. calculates how many minutes were worked that day
# 4. prints total time worked that day in hours and minutes.
######################################
# functions
######################################
# convert_time takes time in hours and time in minutes and
# converts this to number of minutes elapsed since the previous midnight.
# $1: "hours" variable, single or double digit integer indicating the hour
# $2: "minutes" variable, single or double digit integer indicating the minute
# $3: "AMPM" variable, a boolean indicating if the time is AM or PM time.
# temp_abs_time: a variable to store the time in minutes from previous midnight
######################################
function convert_time()
{
    #reset temp variable if needed
    temp_abs_time=0

    #rename numbered parameters to be readable
    local hours=$1
    local minutes=$2
    local AMPM=$3

    #1PM-11PM get 12 hours added.
    #12:00 AM - 12:59AM is transformed into 0:00 - 0:59.
    if [ "$AMPM" == "PM" ] && [ "$hours" -lt 12 ]
    then
         hours=$(( $hours + 12 ));
    elif [ "$AMPM" == "AM" ] && [ "$hours" -eq 12 ]
    then
         hours=0;
    else
        :
    fi

    #transform hours into minutes
    hours=$(( $hours * 60 ))

    temp_abs_time=$(( $minutes + $hours ))
}
######################################
# get_a_time gets hour, minute, AM/PM info from user.
# temp_hours: a variable that holds the hour
# temp_minutes: a variable that holds the minutes
# temp_AMPM: a variable that tells if the time was morning or evening
######################################
function get_a_time()
{
    #reset temp variables if needed
    temp_hours=0
    temp_minutes=0
    temp_AMPM=""
    local choice=""

    echo "Enter the hour: "
    read temp_hours
    echo ""

    echo "Enter the minutes: "
    read temp_minutes
    echo ""

    echo "type 'AM' if the time was AM or 'PM' if the time was PM and press ENTER: "
    read choice
    echo ""

    if [ $choice == "PM" ] || [ $choice == "pm" ]
    then
        temp_AMPM="PM"
    else
        temp_AMPM="AM"
    fi
}

######################################
# introduce program:
######################################
echo "Welcome to TIME CLOCK"

######################################
# initialize global variables
######################################
# time in
time_in_hr=0
time_in_min=0
time_in_AMPM="AM"
abs_time_in=0

# lunch out
lunch_out_hr=0
lunch_out_min=0
lunch_out_AMPM="AM"
abs_lunch_out=0

# lunch in
lunch_in_hr=0
lunch_in_hr=0
lunch_in_AMPM="PM"
abs_lunch_in=0

# time out
time_out_hr=0
time_out_min=0
time_out_AMPM="PM"
abs_time_out=0

# variables used by functions
temp_hours=0
temp_minutes=0
temp_AMPM=""
temp_abs_time=0

#other variables
pre=0
post=0
total_time=0
hours_worked=0
minutes_worked=0

######################################
# Read input into variables
######################################

echo "Enter the time employee clocked IN for WORK: "

get_a_time

time_in_hours=$temp_hours
time_in_minutes=$temp_minutes
time_in_AMPM=$temp_AMPM

echo "Enter the time employee clocked OUT for LUNCH: "
get_a_time

lunch_out_hours=$temp_hours
lunch_out_minutes=$temp_minutes
lunch_out_AMPM=$temp_AMPM

echo "Enter the time employee clocked IN from LUNCH: "
get_a_time

lunch_in_hours=$temp_hours
lunch_in_minutes=$temp_minutes
lunch_in_AMPM=$temp_AMPM

echo "Enter the time employee clocked OUT of WORK: "
get_a_time

time_out_hours=$temp_hours
time_out_minutes=$temp_minutes
time_out_AMPM=$temp_AMPM

######################################
# Convert times to minutes from midnight
######################################

convert_time $time_in_hours $time_in_minutes $time_in_AMPM
abs_time_in=$temp_abs_time

convert_time $lunch_out_hours $lunch_out_minutes $lunch_out_AMPM
abs_lunch_out=$temp_abs_time

convert_time $lunch_in_hours $lunch_in_minutes $lunch_in_AMPM
abs_lunch_in=$temp_abs_time

convert_time $time_out_hours $time_out_minutes $time_out_AMPM
abs_time_out=$temp_abs_time

######################################
# Get hours worked
######################################

pre=$(( $abs_lunch_out - $abs_time_in ))
post=$(( $abs_time_out - $abs_lunch_in ))

total_time=$(( $pre + $post ))

hours_worked=$(( $total_time / 60 ))
minutes_worked=$(( $total_time % 60 ))

######################################
# Print total time worked for user
######################################

echo "The employee worked $hours_worked hours and $minutes_worked minutes today."

######################################
# end program
######################################
echo 'All Done!'
