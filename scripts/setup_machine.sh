#!/bin/bash

sudo apt install -y apt-utils wget curl jq unzip bc
cd src/zombie-lord
sudo ./video.deps
sudo ./audio.deps
sudo ./deb.deps
sudo ./font.deps
sudo ./pptr.deps
sudo ./dlchrome.sh
cd ../..
sudo npm i -g node-dev nodemon
sudo apt install -y libvips libjpeg-dev
./scripts/install_bundle_deps.sh
./scripts/install_global_bundle_deps.sh
sudo ./scripts/install_webp.sh
sudo ./scripts/audio_setup.sh

echo Installing audio config to /etc/pulse/
sudo cp -r src/services/instance/parec-server/pulse/* /etc/pulse/
mkdir -p ~/.config/pulse/
sudo cp -r src/services/instance/parec-server/pulse/* ~/.config/pulse/ 
loginctl enable-linger
sudo mkdir -p /usr/local/lib/systemd/logind.conf.d
sudo echo "KillUserProcesses=no" > /usr/local/lib/systemd/logind.conf.d/nokill.conf

sudo groupadd browsers
sudo groupadd scripters

sudo ufw disable
npm i -g pm2@latest
sudo setcap 'cap_net_bind_service=+ep' $(which node)
