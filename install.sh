#!/bin/bash
read -p "Slack Webhook URL: " webhookUrl
read -p "What's your name? " name
read -p "Organization name: " orgName
read -p "Hashtag of organization name (to group messages): " hashtag

# Make folder
mkdir /opt/ngcron/

# Add variables
echo "export NGCRON_WEBHOOK=\"$webhookUrl\"" >> /opt/ngcron/env
echo "export NGCRON_NAME=\"$name\"" >> /opt/ngcron/env
echo "export NGCRON_ORG_NAME=\"$orgName\"" >> /opt/ngcron/env
echo "export NGCRON_HASHTAG=\"$hashtag\"" >> /opt/ngcron/env

cp ngcron /opt/ngcron/ngcron
chmod a+x /opt/ngcron/ngcron

rm /usr/bin/ngcron
ln -s /opt/ngcron/ngcron /usr/bin/ngcron

echo "Installation finished!"