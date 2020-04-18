sudo find  /sys/devices/system/cpu/ -type d -name "cpu[0-9]*" | grep -e "[0-9]*" -o | xargs sudo cpufreq-selector -f $1 -c

