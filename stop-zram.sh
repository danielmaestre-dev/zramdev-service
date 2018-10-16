#!/bin/sh
##################################################

num_zramdev=`nproc`
for n in $(seq $num_zramdev); do
	i=$((n - 1))
 	swapoff /dev/zram$i
 	echo "\n# Stopped zram$i device"
done

wait
sleep .5 &

modprobe -r zram

echo "\n######################" 
echo " Zram module Disabled"
echo "######################"
 
##################################################
exit 0
