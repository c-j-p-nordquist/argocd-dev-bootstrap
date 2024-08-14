#!/bin/bash

# cleanup.sh

set -e

CLUSTER_NAME="argocd-dev-cluster"

# Check if k3d is installed
if ! command -v k3d &> /dev/null; then
    echo "k3d is not installed. Please install it first."
    exit 1
fi

# Delete the k3d cluster
echo "Deleting K3d cluster: $CLUSTER_NAME"
k3d cluster delete $CLUSTER_NAME

# Remove the cluster from kubeconfig
kubectl config delete-context k3d-$CLUSTER_NAME 2>/dev/null || true
kubectl config delete-cluster k3d-$CLUSTER_NAME 2>/dev/null || true

echo "Cleanup completed successfully!"