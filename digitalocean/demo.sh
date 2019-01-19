#cloud-config

runcmd:
  - wget https://raw.githubusercontent.com/vishalcloudyuga/minikube-on-DigitalOcean/master/install.sh
  - chmod +x install.sh
  - bash install.sh
  - mkdir -p ~/.kube
  - cp /var/lib/minikube/kubeconfig ~/.kube/config


