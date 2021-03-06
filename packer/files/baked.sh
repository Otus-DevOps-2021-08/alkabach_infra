#!/bin/bash

cd ~
sudo apt install -y git-all
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl enable puma.service
sudo systemctl start puma.service
