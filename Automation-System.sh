#!/bin/bash

# Set desktop path (change USERNAME if needed)
CSV_FILE="/mnt/c/Users/peter/Desktop/Logs.csv"  # Fixed path for Windows (WSL)

# Check if CSV file exists, if not, create it with headers
if [ ! -f "$CSV_FILE" ]; then
    echo "Timestamp,CPU_Usage(%),Memory_Usage(%),Disk_Usage(%)" > "$CSV_FILE"
fi

# Loop forever, update every 5 seconds
while true; do
    # Get current timestamp
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # CPU Usage
    if command -v mpstat &> /dev/null; then
        CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')  # More accurate CPU usage
    else
        CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')  # Sum of user+system CPU usage
    fi

    # Memory Usage
    MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')  # Total Memory
    MEM_USED=$(free -m | awk '/Mem:/ {print $3}')   # Used Memory
    MEM_USAGE=$(( 100 * MEM_USED / MEM_TOTAL ))      # Memory usage in %

    # Disk Usage
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')  # Root partition usage in %

    # Append data to CSV file
    echo "$TIMESTAMP,$CPU_USAGE,$MEM_USAGE,$DISK_USAGE" >> "$CSV_FILE"

    # Print to terminal
    echo "Logged: $TIMESTAMP | CPU: $CPU_USAGE% | MEM: $MEM_USAGE% | DISK: $DISK_USAGE%"

    # Wait 5 seconds before next iteration
    sleep 5
done