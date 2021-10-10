#!/bin/bash
echo "Waiting for the apt process to exit to avoid lock error ..."
while pgrep apt
do
	sleep 5
done
set -e
APP_DIR=${1:-$HOME}
sudo apt-get install -y git

echo "Waiting for the apt process to exit to avoid lock error ..."
while pgrep apt
do
	sleep 5
done
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit && bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
