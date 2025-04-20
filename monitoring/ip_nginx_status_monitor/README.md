# Guide to Setting Up Telegram Bot for Monitoring nginx Sites
 
#### Guide to setting up Telegram Bot for monitoring sites on external IPs with different nginx ports

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

## Setting up a cron task for IP monitoring

### 1. Open root cron
```bash
sudo crontab -e
```
### 2. Add a task
In an editor (for example nano), insert the line:

```bash
*/5 * * * * /usr/local/bin/ip_nginx_status_monitor.sh
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
*/5 * * * * /usr/local/bin/ip_nginx_status_monitor.sh
```

Important notes:
```bash
*/5 * * * * - execute every 5 minutes

/path/to/script.sh - full path to your executable script
```