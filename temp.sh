#!/bin/bash

# paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'

temp=$(</sys/class/thermal/thermal_zone0/temp)

temp_f=`echo "$temp/1000" | bc -l`
printf "CPU Temp: %.2f°C\n"  $temp_f
