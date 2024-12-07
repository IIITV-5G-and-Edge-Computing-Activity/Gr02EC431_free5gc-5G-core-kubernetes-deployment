#!/bin/bash

# Display OS release information
cat /etc/os-release

# Display the current kernel version
uname -r

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install necessary dependencies
sudo apt install -y git gcc g++ cmake autoconf libtool pkg-config libmnl-dev libyaml-dev

# Clone the gtp5g repository
git clone https://github.com/free5gc/gtp5g.git

# Change to gtp5g directory
cd gtp5g

# Clean and build gtp5g
make clean && make
make install

# Install MicroK8s
sudo snap install microk8s --classic

# List installed snap packages
sudo snap list

# Create group for MicroK8s and assign user to the group
sudo groupadd microk8s
sudo usermod -a -G microk8s gr02ec431

# Change ownership of kube configuration files
sudo chown -f -R gr02ec431 ~/.kube

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Disable HA-Cluster mode for MicroK8s
microk8s disable ha-cluster --force

# Enable necessary services in MicroK8s
sudo microk8s enable dns ingress dashboard storage community helm3

# Enable Multus (for multiple network interfaces)
microk8s enable multus

# Create a namespace for Free5GC
microk8s kubectl create namespace free5gc

# Set network interface eth0 to promiscuous mode
sudo ip link set eth0 promisc on

# Add Helm repository for Towards5GS
helm repo add towards5gs 'https://raw.githubusercontent.com/Orange-OpenSource/towards5gs-helm/main/repo/'
helm repo update

# Search Helm repositories
helm search repo

# Create directory for persistent storage
mkdir kubedata

# Apply Persistent Volume configuration in Kubernetes
cat <<EOF | microk8s kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-local-pv9
  labels:
    project: free5gc
spec:
  capacity:
    storage: 8Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  local:
    path: /home/gr02ec431/kubedata
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - free5gc
EOF

# Clone Towards5GS Helm charts repository
git clone https://github.com/Orange-OpenSource/towards5gs-helm.git

# Change to the Free5GC Helm chart directory
cd towards5gs-helm/charts/free5gc/charts/

# Install various Free5GC components using Helm
microk8s kubectl create namespace free5gc
microk8s helm3 -n free5gc install udr ./free5gc-udr/
microk8s helm3 -n free5gc install nrf ./free5gc-nrf/
microk8s helm3 -n free5gc install udm ./free5gc-udm/
microk8s helm3 -n free5gc install ausf ./free5gc-ausf/
microk8s helm3 -n free5gc install nssf ./free5gc-nssf/
microk8s helm3 -n free5gc install amf ./free5gc-amf/
microk8s helm3 -n free5gc install pcf ./free5gc-pcf
microk8s helm3 -n free5gc install smf ./free5gc-smf/
microk8s helm3 -n free5gc install upf ./free5gc-upf/
microk8s helm3 -n free5gc install webui ./free5gc-webui/

# Check the status of all pods
microk8s kubectl get pods --all-namespaces

# Check services in the Free5GC namespace
microk8s kubectl get svc -n free5gc

# Install UERANSIM for UE simulation
microk8s helm3 -n free5gc install ueransim ./ueransim/

# Get the pods related to UERANSIM
kubectl -n free5gc get pods -l "app=ueransim"

# Access the UE pod and start a bash shell
kubectl -n free5gc exec -it <ue-pod-name> -- bash

# Check network interfaces and IP addresses in the UE pod
ip address

# Test the network connectivity from UE (ping, traceroute, and curl)
ping -I uesimtun0 www.google.com
traceroute -i uesimtun0 www.google.com
curl --interface uesimtun0 www.google.com

# End of setup script
