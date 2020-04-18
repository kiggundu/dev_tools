cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "intel_pstate" > $file; done

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
