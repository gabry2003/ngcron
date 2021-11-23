#!/bin/bash
read -p "Slack Webhook URL (optional): " webhookUrl
read -p "What's your name? (optional) " name
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
cp slack /opt/ngcron/slack
cp uninstall.sh /opt/ngcron/uninstall.sh
cp README.md /opt/ngcron/README.md

chmod a+x /opt/ngcron/ngcron
chmod a+x /opt/ngcron/slack
chmod a+x /opt/ngcron/uninstall.sh

if test -f "/usr/bin/ngcron"; then  # If script exists
    rm "/usr/bin/ngcron"
fi

ln -s /opt/ngcron/ngcron /usr/bin/ngcron

echo "Installation finished!"