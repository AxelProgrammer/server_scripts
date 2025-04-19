#!/bin/bash

# ==============================
# | Author: Axel Polozhentsev  |
# | Creation date: 19.04.2025  |
# | Date of change: 19.04.2025 |
# | Сommit: 1.0.1              |
# ==============================

# Telegram settings
TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN"
TELEGRAM_CHAT_ID="YOUR_CHAT_ID"

# We receive connection data
SSH_USER=$(whoami)
SSH_CLIENT_IP=$(echo $SSH_CONNECTION | awk '{print $1}')
HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# We receive geodata
GEO_INFO=$(curl -s "http://ip-api.com/json/$SSH_CLIENT_IP?fields=status,country,city,isp")
COUNTRY=$(echo "$GEO_INFO" | jq -r '.country // "Unknown"')
CITY=$(echo "$GEO_INFO" | jq -r '.city // "Unknown"')
ISP=$(echo "$GEO_INFO" | jq -r '.isp // "Unknown"')

# Forming a message
MESSAGE="🔔 SSH Login Alert 🔔
🕒 Time: $DATE
🖥️ Host: $HOSTNAME
👤 User: $SSH_USER
🌐 IP: $SSH_CLIENT_IP
📍 Location: $CITY, $COUNTRY
🔌 ISP: $ISP"

# Send to Telegram
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="$MESSAGE" > /dev/null

# Logging to a file
echo "[$DATE] $SSH_USER from $SSH_CLIENT_IP ($CITY, $COUNTRY)" >> /var/log/ssh_connections.log