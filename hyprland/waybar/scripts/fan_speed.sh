#!/bin/bash
speed=$(cat /sys/class/hwmon/hwmon6/fan1_input)
echo " ${speed} RPM"

