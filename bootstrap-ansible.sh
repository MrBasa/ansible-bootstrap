#!/bin/bash
set -e

echo "🚀 Starting Ansible Bootstrap..."

# Detect distribution and install Ansible
if command -v apt >/dev/null 2>&1; then
    echo "📦 Detected Debian/Ubuntu, installing ansible-core..."
    sudo apt update && sudo apt install -y ansible-core git
elif command -v dnf >/dev/null 2>&1; then
    echo "📦 Detected Fedora, installing ansible-core..."
    sudo dnf install -y ansible-core git
elif command -v pacman >/dev/null 2>&1; then
    echo "📦 Detected Arch Linux, installing ansible-core..."
    sudo pacman -Syu --noconfirm --needed ansible-core git
else
    echo "❌ Unsupported distribution. Please install ansible-core manually."
    exit 1
fi

echo "✅ Ansible installed successfully!"
echo "📥 Running Ansible playbook..."

# Run ansible-pull with the repository
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, bootstrap-ansible-pull.yml -K

echo "🎉 Bootstrap complete!"
