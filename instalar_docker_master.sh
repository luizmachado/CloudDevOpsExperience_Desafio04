#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

apt update
apt install -y nfs-server
docker swarm init --advertise-addr 199.199.0.2
docker swarm join-token -q worker > /vagrant/swarm_token
docker volume create app
echo "/var/lib/docker/volumes/app/_data/ 199.199.0.0/24(rw,sync,subtree_check)" >> /etc/exports
exportfs -ar
cp -r /vagrant/app/* /var/lib/docker/volumes/app/_data/
docker service create --name webserver --replicas 15 -dt -p 80:80 --mount type=volume,src=app,dst=/usr/local/apache2/htdocs httpd
