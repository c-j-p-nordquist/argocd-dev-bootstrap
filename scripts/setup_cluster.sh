#!/bin/bash

# setup_cluster.sh

set -e

# Check if k3d is installed
if ! command -v k3d &> /dev/null; then
    echo "k3d is not installed. Please install it first."
    exit 1
fi

# Create a new k3d cluster
CLUSTER_NAME="argocd-dev-cluster"

echo "Creating K3d cluster: $CLUSTER_NAME"
k3d cluster create $CLUSTER_NAME --agents 2

# Wait for the cluster to be ready
echo "Waiting for the cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "Cluster $CLUSTER_NAME is ready!"

# K3d automatically updates kubeconfig and sets the new cluster as the current context
echo "K3d has automatically updated your kubeconfig."
echo "Current kubectl context: $(kubectl config current-context)"

# Install Helm
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
else
    echo "Helm is already installed."
fi

# Verify Helm installation
helm version

# Verify the current context
kubectl cluster-info