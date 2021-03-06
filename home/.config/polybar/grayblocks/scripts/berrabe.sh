#!/bin/bash

#  FOR TINT2 ONLY !!!!

# while true
# 	do

		if [[ $1 == 1 ]]
			then
				# echo "  $(cat /sys/devices/virtual/dmi/id/product_version)"
				echo "  $(hostname)"
				exit


		elif [[ $1 == 2 ]]
			then
				# temp=$(sensors | egrep "Core [0-7]" | sed -r 's/.*:\s+[\+-]?(.*C)\s+.*/\1/' | tr '\n' ' ')
				temp=$(sensors | awk '/^Core /{++r; gsub(/[^[:digit:]]+/, "", $3); s+=$3} END {printf("%.0f°C",s/(10*r))}')
				echo " $temp"

		
		elif [[ $1 == 3 ]]
			then
				# cpu=$(cat /proc/cpuinfo | grep -i "cpu MHz" | cut -b 12-15 | tr '\n' ' ')
				freq=$(cat /proc/cpuinfo | grep -i "cpu MHz" | cut -b 12-15 | awk '{total+=$1; count+=1} END {printf("%.0f MHz",total/count)}')
				echo "龍 $freq"

		
		elif [[ $1 == 4 ]]
			then
				memory=$(awk '/^Mem/ {print $3 " MB"}' <(free -m))
				echo " $memory"


		elif [[ $1 == 5 ]]
			then
				# Note the use of "stdbuf -oL" to force the program to flush the output line by line.
				# stdbuf -oL bwm-ng -o csv -t 1000 | awk -v ical="$(iwgetid | cut -b 17- | sed -z 's/"//g')" -F ';' '/total/ { printf "  %s     %.02f Mb/s\n", ical,($5*8/1.0e6)}; fflush(stdout)'
				stdbuf -oL bwm-ng -o csv -t 1000 | awk -F ';' '/total/ { printf " %.02f Mb/s\n",($5*8/1.0e6)}; fflush(stdout)'


		elif [[ $1 == 6 ]]
			then
				xprop -root -spy | awk '/^_NET_CURRENT_DESKTOP/ { print " " ($3 + 1) " /   "; fflush(); }'
		

		fi

	# sleep $2

	# done