#!/bin/bash
{
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubectl socat 
}
{curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube
}

{
cat <<EOF> /etc/docker/daemon.json
{
  "insecure-registries" : ["0.0.0.0/0"]
}
EOF
}

{
systemctl restart docker
}

{
minikube config set embed-certs true
minikube start --vm-driver none
}
