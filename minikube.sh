#!/bin/bash -xe

name=$1
sshkey=$2

doctl compute droplet create --size 4gb --image ubuntu-16-04-x64 --region blr1 --ssh-keys $sshkey --enable-private-networking --tag-name $name $name

while true; do
   status=$(doctl compute droplet ls ${name} --no-header --format "Status")
   if [ "$status" == "active" ]; then
      echo "Droplet is active"
      break
   fi
   echo "Waiting for 2 sec. Dropet not ready yet. Status=$status"
   sleep 2
done

IP="$(doctl compute droplet list ${name} --no-header --format PublicIPv4)"

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null install.sh root@$IP:~/.

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP 'bash install.sh'

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$IP:~/.kube/config kubeconfig

echo "Your Minikube IP is $IP" >ip.txt
cat ip.txt

