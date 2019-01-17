# minikube-on-DigitalOcean

- Install `doctl`

```
cd ~
wget https://github.com/digitalocean/doctl/releases/download/v1.12.2/doctl-1.12.2-linux-amd64.tar.gz
tar xf ~/doctl-1.12.2-linux-amd64.tar.gz
sudo mv ~/doctl /usr/local/bin
```

- Initialize your `doctl`.

```
doctl auth init
```

- You will be prompted to enter the DigitalOcean access token that you generated in the DigitalOcean control panel.

```
DigitalOcean access token: your_DO_token
```
After entering your token, you will receive confirmation that the credentials were accepted. If the token doesn't validate, make sure you copied and pasted it correctly.

```
Validating token: OK
```

This will create the necessary directory structure and configuration file to store your credentials.


- Install `kubectl`.

```
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```


- Clone the git repo.

```
git clone https://github.com/vishalcloudyuga/minikube-on-DigitalOcean
cd minikube-on-DigitalOcean
```

- Choose your kubernetes version.

```
git checkout tags/v1.13.0
```
Or
```
git checkout tags/v1.12.0
```

- Start minikube.

```
bash minikube.sh <your-name> <ssh-key-id>
```

- Start using kubernetes.

```
export KUBECONFIG=$(pwd)/kubeconfig
```

- Verify the node.

```
kubectl get nodes
```
