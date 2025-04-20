#!/bin/bash

# ==============================
# | Author: Axel Polozhentsev  |
# | Creation date: 20.04.2025  |
# | Date of change: 20.04.2025 |
# | Сommit: 1.0.2              |
# ==============================

# Configuration
BOT_TOKEN=""
CHAT_ID=""
SERVER_IP=""
PORTS=("80" "8080" "8888")
STATUS_FILE="/tmp/nginx_sites_status.txt"
INIT_FLAG_FILE="/tmp/nginx_monitor_initialized.flag"
# Send message function in Telegram
send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${message}" \
        -d parse_mode="Markdown" > /dev/null
}

# Sending a message about the start of work (only at the first launch)
if [ ! -f "$INIT_FLAG_FILE" ]; then
    touch "$INIT_FLAG_FILE"
    startup_message="🟢 Monitoring sites on the server ${SERVER_IP} launched! Monitoring ports: ${PORTS[*]}"
    send_telegram_message "$startup_message"
fi

# We check if the status file exists, if not, we create it
if [ ! -f "$STATUS_FILE" ]; then
    touch "$STATUS_FILE"
    # Initialize all statuses as "unknown"
    for port in "${PORTS[@]}"; do
        echo "$port:unknown" >> "$STATUS_FILE"
    done
fi

# Check each port
for port in "${PORTS[@]}"; do
    # Checking the availability of the site
    if curl -s -I --connect-timeout 5 "http://${SERVER_IP}:${port}" > /dev/null; then
        current_status="up"
    else
        current_status="down"
    fi

    # Get the previous status from the file
    previous_status=$(grep "^$port:" "$STATUS_FILE" | cut -d':' -f2)
    # logging events
    echo "PORT: $port | PREV: $previous_status | NOW: $current_status" >> /tmp/nginx_monitor_debug.log
    # If the status has changed
    if [ "$current_status" != "$previous_status" ]; then
        # Update the status in the file
        sed -i "s/$port:.*/$port:$current_status/" "$STATUS_FILE"
        # Forming a message
        if [ "$current_status" == "up" ]; then
            message="✅ Site at the port ${port} available again!"
        else
            message="❌ Site at the port ${port} became unavailable!"
        fi
        # Send a message to Telegram
        send_telegram_message "$message"
    fi
done