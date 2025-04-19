# Telegram Bot Configuration Guide for ssh Connection Monitoring
 
#### Script for monitoring ssh connection and sending notifications to Telegram

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
## Setting up launch and debugging
### 1. Create a script and open it for editing:
instead of /usr/local/bin/ specify the path to the folder in which you would like to place the script
```bash 
sudo nano /usr/local/bin/connection_tracker.sh
```

### 2. We make the script executable:
```bash
sudo chmod +x /usr/local/bin/connection_tracker.sh
```

### 3. Install jq to handle JSON (if not):
```bash
sudo apt install jq -y
```

### 4. Configure automatic startup upon SSH connection:
```bash
sudo nano /etc/pam.d/sshd
```

Add to the end of the file:
```bash
session optional pam_exec.so /usr/local/bin/connection_tracker.sh
```

### 5. Restart SSH:
```bash
sudo systemctl restart ssh
```

### 6. Check the logs (optional):
```bash
tail -f /var/log/ssh_connections.log
```