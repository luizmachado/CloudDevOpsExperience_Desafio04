#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

apt update
apt install -y nfs-common
docker swarm join --token $(cat /vagrant/swarm_token) 199.199.0.2:2377
mkdir -p /var/lib/docker/volumes/app/_data
mount 199.199.0.2:/var/lib/docker/volumes/app/_data /var/lib/docker/volumes/app/_data
