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

## Send message
ngcron can send you a message with the data to connect via ngrok, by default it uses **Slack**.
If you want to use another platform to send messages or you want to send messages in a customized way add in the **/opt/ngcron/** folder a program or script called **send_msg** that receives the arguments and makes a certain call.

The important thing is to know that as the first argument it receives the message to be sent and as the second the slack webhook (you can safely ignore it if you don't use Slack to send messages).

Don't forget of course to add permissions to the send_msg file to make it work.

If you choose Slack You must insert a [Slack Webhook URL](https://api.slack.com/messaging/webhooks).
ngcron can connect to slack via webhooks and uses the **/opt/ngcron/slack** script.
You can also use this script to send messages for other purposes, for example:

``` bash
/opt/ngcron/slack "Hello Bob" "$WEBHOOK_URL"
```

## How to start at PC power on?
Exec command:
``` bash
crontab -e
```

And insert

``` bash
@reboot sleep 5 && ngcron 22 'SSH' '/opt/ngrok/ngrok.yml' &
```

Example of start ngrok SSH and VNC at start up:
**crontab -e**

In this way cron wait 5 seconds and after start two ngrok async with a delay of 10 seconds.

```
@reboot sleep 5 && declare -a files=( "/usr/bin/on_reboot_ssh.sh" "/usr/bin/on_reboot_vnc.sh" ); length=${#files[@]}; for (( i=0; i < ${length}; i++ )); do /usr/bin/bash "${files[i]}" & sleep 10; done
```

**/usr/bin/on_reboot_ssh.sh**

``` bash
##!/bin/bash

ngcron 22 'SSH' '/opt/ngrok/ngrok.yml'
```

**/usr/bin/on_reboot_vnc.sh**

``` bash
##!/bin/bash

ngcron 5901 'VNC' '/opt/ngrok/another_ngrok.yml'
```

## Logs
Logs is in file: "/tmp/ngrok.log"