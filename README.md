# ArgoCD Dev Environment Bootstrap

This project sets up a local Kubernetes cluster with ArgoCD installed using Helm, providing a foundation for ArgoCD and Kubernetes development and testing.

## Prerequisites

- Docker
- [K3d](https://k3d.io/) (installation instructions below)

## Installation

### Installing K3d

K3d is a lightweight wrapper to run K3s (Rancher Lab's minimal Kubernetes distribution) in Docker. Here are instructions for different operating systems:

#### Linux and macOS

You can use the installation script:

```bash
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

Or with curl:

```bash
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

#### macOS with Homebrew

If you're using Homebrew on macOS, you can install K3d with:

```bash
brew install k3d
```

#### Windows

On Windows, you can use Chocolatey:

```
choco install k3d
```

Or download the binary from the [K3d releases page](https://github.com/k3d-io/k3d/releases) and add it to your PATH.

After installation, verify K3d is installed correctly:

```bash
k3d version
```

## Project Structure

```
argocd-dev-bootstrap/
├── README.md
├── scripts/
│   ├── setup_cluster.sh
│   ├── install_argocd.sh
│   └── cleanup.sh
└── examples/
    └── sample-application.yaml
```

## Setup Steps

1. **Create a local Kubernetes cluster and install Helm**
   Run the following command:
   ```
   ./scripts/setup_cluster.sh
   ```
   This script creates a K3d cluster named "argocd-dev-cluster" and installs Helm. K3d automatically updates your kubeconfig and sets the new cluster as the current context.

2. **Install ArgoCD using Helm**
   Run:
   ```
   ./scripts/install_argocd.sh
   ```
   This script uses Helm to deploy ArgoCD to the local cluster.

3. **Access ArgoCD**
   Follow the instructions provided by Helm after the installation to access the ArgoCD UI and retrieve the initial admin password.

4. **Deploy a sample application** (optional)
   Apply the sample application manifest:
   ```
   kubectl apply -f examples/sample-application.yaml
   ```

## Cleanup

To tear down the environment and remove the cluster, run:
```
./scripts/cleanup.sh
```
This script deletes the K3d cluster and removes it from your kubeconfig.

## Notes on Kubeconfig

- The `setup_cluster.sh` script uses K3d to create a local Kubernetes cluster. 
- K3d automatically updates your kubeconfig, adding a new context named `k3d-argocd-dev-cluster`.
- The new context is set as the current context, so kubectl commands will interact with this cluster by default.
- The `cleanup.sh` script removes the cluster and its associated kubeconfig entries.

## Notes on ArgoCD Installation

The installation script uses Helm to deploy ArgoCD, which manages the creation and configuration of all necessary resources. Helm provides instructions for accessing ArgoCD and retrieving the initial admin password upon completion of the installation.

## Next Steps

This bootstrap project can be used as a starting point for more advanced ArgoCD projects, such as:
- Multi-environment deployments
- Canary release strategies
- GitOps workflows

## Troubleshooting

If you encounter any issues:
1. Ensure all prerequisites are installed correctly.
2. Check that Docker is running.
3. Verify that the scripts have execute permissions (`chmod +x scripts/*.sh`).
4. If the cluster fails to create, try running the cleanup script and then retry the setup.

For more help, please open an issue in this repository.