#!/bin/bash


kubectl() {
    minikube kubectl -- "$@"
}

# Ensure Minikube and Helm are installed
if ! command -v minikube &> /dev/null; then
    echo "Minikube could not be found. Please install it first."
    exit 1
fi

if ! command -v helm &> /dev/null; then
    echo "Helm could not be found. Please install it first."
    exit 1
fi

# Start Minikube with Calico for NetworkPolicy (Make sure the user running the script is in the 'docker' group if using docker driver)
minikube start --network-plugin=cni --cni=calico
if [ $? -ne 0 ]; then
    echo "Minikube failed to start. Please check the error message."
    exit 1
fi

# Enable necessary Minikube addons
minikube addons enable ingress
minikube addons enable ingress-dns

# Wait for all Kubernetes pods to be ready
echo "Waiting for all Kubernetes pods to be ready..."
kubectl wait --for=condition=Ready pod --all --all-namespaces --timeout=10s

# Get the Minikube IP address
MINIKUBE_IP=$(minikube ip)
if [ -z "$MINIKUBE_IP" ]; then
    echo "Failed to get Minikube IP address."
    exit 1
fi

# Update DNS and hosts with sudo
{
    echo -e "\nsearch local\nnameserver $MINIKUBE_IP\ntimeout 5"
    echo -e "\n$MINIKUBE_IP cytomine.local"
    echo -e "$MINIKUBE_IP ims.cytomine.local"
    echo -e "$MINIKUBE_IP upload.cytomine.local"
} | sudo tee -a /etc/resolv.conf /etc/hosts

# Clone the Cytomine Helm chart repository
if [ ! -d "cytomine-bp-helm" ]; then
    git clone https://github.com/NBISweden/cytomine-bp-helm.git
fi

# Navigate to the Helm chart directory
cd cytomine-bp-helm/charts/cytomine || { echo "Failed to find the chart directory"; exit 1; }

# Install the Cytomine Helm chart with the cytomine prefix
helm install cytomine . || { echo "Helm failed to install Cytomine."; exit 1; }

# Inform the user that the setup is complete
echo "Cytomine installation complete."
