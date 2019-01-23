#!/bin/bash

name=$1
sshkey=$2


function usage() {
    echo "Usage: ./minikube.sh <droplet-name> <ssh-id>"
    exit 1
}

if [ -z $name ]; then
    echo "Droplet name is not set"
    usage
fi

if [ -z $sshkey ]; then
    echo "Droplet ssh-id not set"
    usage
fi

doctl compute droplet create --size 8gb --image ubuntu-16-04-x64 --region blr1 --ssh-keys $sshkey --enable-private-networking --tag-name $name $name

while true; do
   status=$(doctl compute droplet ls ${name} --no-header --format "Status")
   if [ "$status" == "active" ]; then
      echo "Droplet is active"
      sleep 2
      break
   fi
   echo "Waiting for 2 sec. Dropet not ready yet. Status=$status"
   sleep 2
done

IP="$(doctl compute droplet list ${name} --no-header --format PublicIPv4)"


while ! ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP hostname; do
    echo "Waiting for ssh to be active"
    sleep 1
done

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null install.sh root@$IP:~/.
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP 'bash install.sh'
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP:~/.kube/config kubeconfig

echo "Your Minikube IP is $IP" >ip.txt
cat ip.txt
