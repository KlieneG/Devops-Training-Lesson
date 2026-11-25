
#!/bin/bash

export LC_ALL=C

# Check disk free space
disk=$(df -h / | awk 'NR==2 {print $4}')

# Check CPU utilization
cpu=$(top -bn2 -d 1 | awk '/Cpu\(s\)/ {usage=100-$8} END {print usage "%"}')

# Check top 5 processes
processes=$(ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6)

# Check system uptime
system_uptime=$(uptime -p)

# Check failed logins
if [ -r /var/log/auth.log ]; then
    failed_login=$(grep -ic "authentication failure" /var/log/auth.log)
else
    failed_login="Unavailable"
fi

# Check RAM usage
ram=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

# Display results
echo "===== Linux Resource Monitoring ====="
echo "Disk Free: $disk"
echo "CPU Usage: $cpu"
echo "Uptime: $system_uptime"
echo "Failed Login: $failed_login"
echo "RAM Usage: $ram"
echo "Top Processes:"
echo "$processes"

