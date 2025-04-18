#!/bin/bash

# ==============================
# | Author: Axel Polozhentsev  |
# | Creation date: 18.04.2025  |
# | Date of change: 18.04.2025 |
# | Сommit: 1.0.0              |
# ==============================

BOT_TOKEN=""  # Replace with real token!
CHAT_ID="" # Your chat_id
LAST_IP_FILE="/tmp/last_ip.txt" # file with last saved ip

# Get the current IP
CURRENT_IP=$(curl -s ifconfig.me)

# Checking for IP change
if [ -f "$LAST_IP_FILE" ]; then
    LAST_IP=$(cat "$LAST_IP_FILE")
    if [ "$CURRENT_IP" != "$LAST_IP" ]; then
        MESSAGE="🔄 IP changed! New: $CURRENT_IP (was: $LAST_IP)"
        curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
            -d "chat_id=$CHAT_ID&text=$MESSAGE"
        echo "$CURRENT_IP" > "$LAST_IP_FILE"
    fi
else
    echo "$CURRENT_IP" > "$LAST_IP_FILE"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID&text=🤖 IP Monitoring is enabled. Current IP: $CURRENT_IP"
fi