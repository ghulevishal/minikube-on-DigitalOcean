#!/bin/bash

source ~/.bashrc

doctl compute droplet create --size 4gb --image ubuntu-16-04-x64 --region blr1 --ssh-keys 20826193 --enable-private-networking --tag-name vishal vishal

sleep 30s

IP="$(doctl compute droplet list | awk '/vishal/ {print $3}')"



scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null install.sh root@$IP:~/.

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP 'bash install.sh'




