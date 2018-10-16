#!/bin/sh
############################
# Configurable parameters #
##################################################

# Choose compression algorithm  "Lzo " or  "LZ4 ".
compression_zramdev=lz4

# Memory percentage "RAM" used by devices "ZRAM".
percent=25

# Device priority "ZRAM ".
priority_zramdev=5

##################################################

#######################
# Processes executed #
##################################################

# Number of devices "ZRAM" based on the number of processor cores.
num_zramdev=`nproc`

# Activate module  "ZRAM".
modprobe zram num_devices=${num_zramdev}

# Calculate amount of memory "RAM" used by devices "ZRAM".
memtotal_str=$(grep 'MemTotal' /proc/meminfo)
memtotal_tmp=${memtotal_str#MemTotal:}
total_memory=${memtotal_tmp%kB}
size_zramdev=$((($total_memory * $percent / 100 / $num_zramdev) * 1024))

# Initialize devices.
for n in $(seq $num_zramdev); do
	i=$((n - 1))

	echo $compression_zramdev > /sys/block/zram$i/comp_algorithm

	echo $size_zramdev > /sys/block/zram$i/disksize

	mkswap /dev/zram$i

	swapon -p $priority_zramdev /dev/zram$i
done

exit 0
