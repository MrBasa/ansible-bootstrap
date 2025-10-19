# Ansible Bootstrap

This repository contains a modular Ansible setup for bootstrapping Linux systems with development tools and utilities. The architecture uses configuration-driven playbooks that share a common package management system.

## Quick Start

1. **Run the bootstrap script to install and configure Ansible:**
   ```bash
   curl -sSL https://raw.githubusercontent.com/mrbasa/ansible-bootstrap/main/bootstrap-ansible.sh | bash
   ```

2. **Install common productivity tools:**
   ```bash
   ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git playbook_common-tools.yml -K
   ```

3. **Install common development tools:**
   ```bash
   ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git playbook_dev-tools-common.yml -K
   ```

## Architecture Overview

The system uses a modular approach where each playbook focuses on a specific category of tools:

- `playbook_ansible-dependencies.yml`: Foundation playbook that installs required Ansible collections and sets up AUR support for Arch Linux
- `playbook_package-managers.yml`: Shared package installation engine that handles multiple package managers (OS packages, pip, cargo, npm, AUR, flatpak)
- `playbook_common-tools.yml`: Installs common productivity tools and utilities that are useful across all development environments
- `playbook_dev-tools.yml**: Installs development-specific tools, language servers, and programming environments using a configuration-driven approach

## Available Playbooks

### Common Tools (`playbook_common-tools.yml`)
Installs essential productivity utilities including modern command-line tools, file managers, text editors, and system monitoring tools. This playbook focuses on tools that enhance daily workflow efficiency.

### Development Tools (`playbook_dev-tools.yml`)
Sets up a comprehensive development environment with language support, build tools, container runtimes, and infrastructure tooling.

## Key Features

- **Simplified Error Handling**: Package manager failures stop execution, but individual package failures continue with detailed reporting
- **Multi-Platform Support**: Works across Debian/Ubuntu, Fedora/RHEL, and Arch Linux distributions
- **AUR Integration**: Automatic setup of AUR package management for Arch Linux
- **Clean Output**: Simplified messaging that shows what's being installed without overwhelming detail
- **Idempotent Operations**: Safe to run multiple times - only makes changes when needed

## Usage Examples

**Install only common tools:**
```bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git playbook_common-tools.yml -K
```

**Install development tools:**
```bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git playbook_dev-tools-common.yml -K
```

## Extending the System

New playbooks can be created by following the same pattern:

1. Define packages in the playbook's **vars** section using the standardized package structure
2. Import `playbook_package-managers.yml` to handle installation
3. Add any post-installation tasks specific to those packages

This modular approach allows for easy creation of specialized playbooks for different tool sets while maintaining consistency and reusing the robust package management foundation.

## Troubleshooting

- If you encounter warnings about host patterns, these are safe to ignore and don't affect functionality
- Use the `-v` flag for more detailed output when debugging issues
- Failed package installations are logged to `/tmp/ansible_package_failures.log` for review
- Playbooks can be safely re-run to complete any failed installations
