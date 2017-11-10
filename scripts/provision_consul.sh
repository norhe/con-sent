#! /bin/bash

echo "Installing dependencies ..."
sudo apt-get -qq update
sudo apt-get install -yqq unzip curl jq
sudo ufw disable

echo "Installing Consul version Consul ..."
sudo cp /vagrant/consul /usr/bin/consul
consul version
echo "Creating directories..."
sudo mkdir -p {/etc/consul.d,/opt/consul/data}
sudo chmod a+w {/etc/consul.d,/opt/consul/data}
echo "Copying config file $1.json"
sudo cp /vagrant/config/$1.json /etc/consul.d/
echo "Starting Consul agent..."
sudo killall consul
nohup consul agent --config-dir=/etc/consul.d 0<&- &>/dev/null &
