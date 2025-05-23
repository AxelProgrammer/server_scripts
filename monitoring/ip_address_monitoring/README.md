# Telegram Bot Setup Guide for IP Monitoring
 
#### Script for monitoring external IP address and sending notifications to Telegram

## 1. Create a Bot and Get Token
1. Open Telegram and search for `@BotFather`
2. Send the command `/newbot`
3. Follow the instructions:
   - Choose a name for your bot (e.g., `My IP Monitor`)
   - Choose a username (must end with `bot`, e.g., `MyIpMonitorBot`)
4. After creation, you'll receive a token in this format:
123456789:ABCdefGHIJKlmNoPQRsTUVwwwZ

(Save this token in a secure place)

## 2. Getting Your CHAT_ID
### Method 1: Via Browser
1. Send any message to your new bot
2. Open this URL in your browser (replace with your token):
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates

3. In the response, find the `"chat":{"id":1907400881}` block - this is your CHAT_ID

### Method 2: Via Terminal (Linux/macOS)
<BOT_TOKEN> change to your chat token
```bash
curl -s "https://api.telegram.org/bot<BOT_TOKEN>/getUpdates" | jq '.result[].message.chat.id'
```
## 3. Understanding LAST_IP_FILE
Purpose
1. Stores the last known IP address (default location: /tmp/last_ip.txt)
2. Used to compare with current IP
3. Created automatically on first run

### How to Change Location
Replace in your script:
```bash
LAST_IP_FILE="/tmp/last_ip.txt"
```
With your preferred path, for example:
```bash
LAST_IP_FILE="$HOME/ip_monitor/last_ip.txt"
```

## Sample Telegram API Response

```json
{
  "ok": true,
  "result": [
    {
      "update_id": 123456789,
      "message": {
        "chat": {
          "id": 1907400881, # chat_id
          "title": "My Chat"
        }
      }
    }
  ]
}
```

## Setting up a cron task for IP monitoring

### 1. Open root cron
```bash
sudo crontab -e
```
### 2. Add a task
In an editor (for example nano), insert the line:

```bash
*/30 * * * * /usr/local/bin/ip_notifier.sh >> /var/log/ip_notifier.log 2>&1
```

### 3. Save changes
For nano:

Press Ctrl+X
Then Y (yes)
And Enter to confirm

### 4. Check the added task
```bash
sudo crontab -l
```
Expected output:

```bash
*/30 * * * * /usr/local/bin/ip_notifier.sh >> /var/log/ip_notifier.log 2>&1
```

Important notes:
```bash
*/30 * * * * - execute every 30 minutes

/path/to/script.sh - full path to your executable script

>> /path/to/log.log - redirect output to a log file

2>&1 - redirect errors to the same log file
```

Additional settings
Before adding a task, make sure that:

The log file exists: sudo touch /var/log/ip_notifier.log

The correct permissions are set:

```bash
sudo chmod 644 /var/log/ip_notifier.log
sudo chown root:root /var/log/ip_notifier.log
```