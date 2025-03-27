#!/bin/bash

# Define log file
LOG_FILE="$HOME/system_optimization.log"

# Function to log output
log_message() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# 1️⃣ Delete Temporary Files
log_message "Deleting temporary files..."
sudo rm -rf /tmp/* /var/tmp/*
log_message "Temporary files deleted."

# 2️⃣ Clear APT Cache (Ubuntu/Debian)
log_message "Cleaning APT cache..."
sudo apt clean -y
log_message "APT cache cleaned."

# 3️⃣ Restart Important Services
log_message "Restarting networking and essential services..."
SERVICES=("networking" "ssh" "apache2")  # Modify for your system
for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        sudo systemctl restart "$service"
        log_message "$service restarted successfully."
    else
        log_message "$service is not running."
    fi
done

# 4️⃣ Perform System Update & Upgrade
log_message "Updating package lists..."
sudo apt update -y && sudo apt upgrade -y
log_message "System update completed."


log_message "System optimization complete! ✅"
