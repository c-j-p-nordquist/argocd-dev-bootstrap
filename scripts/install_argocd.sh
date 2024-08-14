#!/bin/bash

# install_argocd.sh

set -e

# Check if kubectl is installed and the cluster is accessible
if ! kubectl get nodes &> /dev/null; then
    echo "Unable to access the Kubernetes cluster. Please check your kubeconfig."
    exit 1
fi

# Check if Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Helm is not installed. Please run setup_cluster.sh first."
    exit 1
fi

# Add the ArgoCD Helm repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Install ArgoCD using Helm
echo "Installing ArgoCD..."
helm install argocd argo/argo-cd --namespace argocd --create-namespace

echo "ArgoCD installation complete."

# Display ArgoCD version
echo "ArgoCD version:"
helm list -n argocd