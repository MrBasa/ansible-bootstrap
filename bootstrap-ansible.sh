#!/bin/bash
# Bootstrap script to prepare system for additional Ansible playbooks to be run.
set -euo pipefail
trap 'handle_error ${LINENO}' ERR

# Log file location
LOG_FILE="${HOME}/bootstrap-$(date +%Y%m%d).log"

# Start logging
exec > >(tee -a "$LOG_FILE")
exec 2>&1

echo "🚀 Starting Ansible Bootstrap...  - " $(date +"%T")

# --- Error handler function ---
handle_error() {
    echo "❌ Error occurred in script at line: $1"
    echo "💡 Check the log file: $LOG_FILE"
    exit 1
}

# --- GitHub authentication function ---
setup_github_auth2() {
	echo "🔧 Setting up GitHub CLI Authentication..."
    if gh auth status &>/dev/null; then
        echo "✅ GitHub CLI is already authenticated."
        return 0
    fi
    
    echo "Starting device-based authentication..."
    echo "You will need to visit https://github.com/login/device and enter the code below."
    
    # Use device flow (non-interactive, terminal-friendly)
    if gh auth login --device-code -h github.com -p https -s read:org,repo,workflow; then
        echo "✅ GitHub authentication successful!"
        return 0
    else
        echo "❌ GitHub authentication failed."
        echo "You can manually run: gh auth login --device-code"
        return 1
    fi
}

# --- GitHub authentication function ---
setup_github_auth() {
	echo "🔧 Setting up GitHub CLI Authentication..."
    if gh auth status &>/dev/null; then
        echo "✅ GitHub CLI is already authenticated."
        return 0
    fi
    
    echo "Starting device-based authentication..."
     
    # Use BROWSER=false to prevent trying to open a browser
    # This triggers the device flow with manual code entry
    if BROWSER=false gh auth login --web -h github.com -p https -s read:org,repo,workflow; then
        echo "✅ GitHub authentication successful!"
        return 0
    else
        echo "❌ GitHub authentication failed."
        echo "You can manually run: BROWSER=false gh auth login --web"
        return 1
    fi
}

# --- Git configuration function ---
setup_git_config2() {
    echo "🔧 Setting up Git configuration..."
    
    # Set Git user name if not configured
    if ! git config --global --get user.name > /dev/null; then
        echo "Please enter your Git user name:"
        read -r git_name
        git config --global user.name "$git_name"
        echo "-> ✅ Set Git user.name to: $git_name"
    else
        echo "-> ✅ Git user.name already configured: $(git config --global user.name)"
    fi
    
    # Set Git user email if not configured
    if ! git config --global --get user.email > /dev/null; then
        echo "Please enter your Git user email:"
        read -r git_email
        git config --global user.email "$git_email"
        echo "-> ✅ Set Git user.email to: $git_email"
    else
        echo "-> ✅ Git user.email already configured: $(git config --global user.email)"
    fi
    
    # Set some sensible defaults
    git config --global pull.rebase false
    git config --global init.defaultBranch main
    echo "✅ Git configuration complete!"
}

# --- Git configuration function ---
setup_git_config() {
    echo "🔧 Setting up Git configuration..."
    
    # Set Git user name if not configured
    if ! git config --global --get user.name > /dev/null; then
        echo "Please enter your Git user name:"
        read -r git_name < /dev/tty
        git config --global user.name "$git_name"
        echo "✅ Set Git user.name to: $git_name"
    else
        echo "✅ Git user.name already configured: $(git config --global user.name)"
    fi
    
    # Set Git user email if not configured  
    if ! git config --global --get user.email > /dev/null; then
        echo "Please enter your Git user email:"
        read -r git_email < /dev/tty
        git config --global user.email "$git_email"
        echo "✅ Set Git user.email to: $git_email"
    else
        echo "✅ Git user.email already configured: $(git config --global user.email)"
    fi
    
    # Set some sensible defaults
    git config --global pull.rebase false
    git config --global init.defaultBranch main
    echo "✅ Git configuration complete!"
}

# --- SCRIPT BODY BEGIN ---
# --- Detect distribution and install Ansible ---
if command -v apt >/dev/null 2>&1; then
    echo "📦 Detected Debian/Ubuntu, installing ansible-core, git, and gh..."
    sudo apt update && sudo apt install -y ansible-core git gh
elif command -v dnf >/dev/null 2>&1; then
    echo "📦 Detected Fedora, installing ansible-core, git, and gh..."
    sudo dnf install -y ansible-core git gh
elif command -v pacman >/dev/null 2>&1; then
    echo "📦 Detected Arch Linux, installing ansible-core, git and gh..."
    sudo pacman -Syu --noconfirm --needed ansible-core git github-cli
else
    echo "❌ Unsupported distribution!"
    exit 1
fi

echo "✅ Core dependencies installed successfully!"

# --- Install community.general ---
echo "📦 Installing community.general Galaxy collection..."
ansible-galaxy collection install community.general
echo "✅ Galaxy community.general installed successfully!"

# --- Git configuration ---
setup_git_config

# --- GitHub configuration ---
if ! setup_github_auth; then
    exit 1
fi

# --- Ansible-Bootstrap playbook ---
echo "📥 Running Ansible playbook..."
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git playbook_ansible-dependencies.yml -K
echo "✅ Ansible Dependencies playbook complete!"

echo "🎉 Bootstrap complete!  - " $(date +"%T")
exit 0
