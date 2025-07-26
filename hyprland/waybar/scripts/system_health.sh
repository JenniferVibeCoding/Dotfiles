#!/bin/bash

# Read CPU temp (coretemp hwmon4)
cpu_temp=$(cat /sys/class/hwmon/hwmon4/temp1_input)
cpu_temp=$((cpu_temp / 1000))

# GPU temp
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

# NVMe drive temp
drive_temp=$(cat /sys/class/hwmon/hwmon1/temp1_input)
drive_temp=$((drive_temp / 1000))

# Fan speed (example from fan1)
fan_speed=$(sensors | awk '/fan1:/ {print $2 " RPM"; exit}')

# RAM usage
ram_used=$(free -h | awk '/Mem:/ {print $3}')

# CPU usage %
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{u=$2+$4; t=$2+$4+$5+$6+$7+$8+$9+$10; if (NR==1) {prev_u=u; prev_t=t; next} print int((u-prev_u)*100/(t-prev_t))}' | tail -n1)

# Color logic
color_temp() {
  if [ "$1" -ge 80 ]; then
    echo "%{F#ff5555}$1°C%{F-}"  # red
  elif [ "$1" -ge 65 ]; then
    echo "%{F#f1c40f}$1°C%{F-}"  # yellow
  else
    echo "$1°C"  # default
  fi
}

cpu_color=$(color_temp "$cpu_temp")
gpu_color=$(color_temp "$gpu_temp")
drive_color=$(color_temp "$drive_temp")

# Final output
echo "Sys: CPU $cpu_color | GPU $gpu_color | Drive $drive_color | Fans $fan_speed | RAM $ram_used | CPU Load ${cpu_usage}%"
