# ngcron
## Requirements
- cron
- GNU timeout
- Open SSH enabled
- Slack Webhook URL to send messages

**ngcron** is a script created to start ngrok in the background and send a message to Slack with the URL of the connection.
It is called ngcron because this script will be added to **CRON** and will be executed when the computer is turned on.
Thanks to this script you can then have a colleague turn on your computer when you are not in the office and connect remotely via SSH without problems.

## Install
``` bash
chmod a+x install.sh
sudo ./install.sh
```

## How to use
``` bash
# Port
# Protocol
# Path of configuration file
ngcron 22 'SSH' '/opt/ngrok/ngrok.yml'
```

## Slack
You must insert a [Slack Webhook URL](https://api.slack.com/messaging/webhooks).

## How to start at PC power on?
Exec command:
``` bash
crontab -e
```

And insert

``` bash
@reboot sleep 5 && ngcron 22 'SSH' '/opt/ngrok/ngrok.yml' &
```

## Logs
Logs is in file: "/tmp/ngrok.log"