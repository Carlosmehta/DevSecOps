#!/bin/bash

set -e

echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing base development tools..."
sudo apt install -y \
  git curl wget unzip gnupg lsb-release ca-certificates \
  python3 python3-pip python3-venv \
  build-essential software-properties-common \
  jq yq htop net-tools tmux tree zsh

echo "🐳 Installing Docker and Docker Compose..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "🧰 Installing Ansible..."
sudo apt install -y ansible

echo "☁️ Installing Terraform..."
TERRAFORM_VERSION="1.8.4"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "📦 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "🎛️ Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "🔒 Installing Security Tools..."
sudo apt install -y nmap wireshark
pip3 install trivy checkov

echo "🔐 Installing GPG and Vault..."
sudo apt install -y gnupg2
VAULT_VERSION="1.16.1"
wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
unzip vault_${VAULT_VERSION}_linux_amd64.zip
sudo mv vault /usr/local/bin/
rm vault_${VAULT_VERSION}_linux_amd64.zip

echo "✅ Installing k9s (Kubernetes CLI UI)..."
K9S_VERSION="v0.32.4"
wget https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz
tar -xvf k9s_Linux_amd64.tar.gz
sudo mv k9s /usr/local/bin/
rm k9s_Linux_amd64.tar.gz

echo "✨ Optional: Installing Oh-My-Zsh"
sudo apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🎉 All tools installed! Please reboot or log out and log back in to apply group changes (e.g., Docker)."

