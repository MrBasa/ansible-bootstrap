# Ansible Bootstrap

This repository contains Ansible playbooks to bootstrap a new Linux machine (Debian, Fedora, or Arch-based). It provides a modular system for installing development tools and environments through configuration-driven playbooks.

---

## New Playbook Architecture

### Core Playbooks

| Playbook | Purpose | Dependencies |
|----------|---------|--------------|
| `playbook_ansible-dependencies.yml` | Installs required Ansible collections and AUR setup | None |
| `playbook_common-tools.yml` | Installs common productivity tools and utilities | `playbook_ansible-dependencies.yml` |
| `playbook_dev-tools.yml` | Installs development tools and environments (configuration-driven) | `playbook_ansible-dependencies.yml`, `config_dev-tools.yml` |
| `playbook_package-managers.yml` | Universal package installer (used by other playbooks) | `playbook_ansible-dependencies.yml` |

### Configuration
- `config_dev-tools.yml` - Defines package groups and individual packages with rich metadata

---

## Quick Start

### Step 1: Install Dependencies & Clone Repo

"On all systems:"
```bash
# Install Ansible and Git
sudo apt update && sudo apt install -y ansible-core git  # For Debian/Ubuntu
sudo dnf install -y ansible-core git                     # For Fedora
sudo pacman -Syu --needed ansible-core git base-devel    # For Arch

# Clone this repository
git clone https://github.com/mrbasa/ansible-bootstrap.git
cd ansible-bootstrap
```
*Note for Arch: The `base-devel` package group is required to build AUR packages.*

### Step 2: Run the Playbooks

Install common productivity tools:
```bash
	ansible-playbook playbook_common-tools.yml -K
```

Install development environment (default: common-dev-tools + language-servers):
```bash
	ansible-playbook playbook_dev-tools.yml -K
```

Install specific development groups:
```bash
	ansible-playbook playbook_dev-tools.yml -K -e '{"languages": ["python-dev", "rust-dev"], "databases": ["postgresql"]}'
```

---

## Development Environment Playbook

The `playbook_dev-tools.yml` uses a configuration-driven approach where you specify which package groups to install. Packages are defined individually and can belong to multiple groups without duplication - the playbook automatically handles duplicate package installation.

### Available Package Groups

| Category | Group | Description |
|----------|-------|-------------|
| "Core" | `common-dev-tools` | Essential development tools (git, compilers, editors) |
| "Core" | `language-servers` | LSP servers for enhanced editor support |
| "Core" | `linters` | Code linting and formatting tools |
| "Containers" | `container-podman` | Podman container toolkit (daemonless) |
| "Containers" | `container-docker` | Docker container platform |
| "Infrastructure" | `infrastructure-tools` | Kubernetes, Helm, Terraform |
| "Languages" | `python-dev` | Python development environment |
| "Languages" | `go-dev` | Go development environment |
| "Languages" | `rust-dev` | Rust development environment |
| "Languages" | `nodejs-dev` | Node.js development environment |
| "Databases" | `postgresql` | PostgreSQL server and tools |
| "Databases" | `redis` | Redis in-memory data store |
| "Databases" | `sqlite` | SQLite embedded database |

### Usage Examples

Install only common development tools and language servers (default):
```bash
	ansible-playbook playbook_dev-tools.yml -K
```

Install Python and PostgreSQL:
```bash
	ansible-playbook playbook_dev-tools.yml -K -e '{"languages": ["python-dev"], "databases": ["postgresql"]}'
```

Install multiple languages with infrastructure tools:
```bash
	ansible-playbook playbook_dev-tools.yml -K -e '{"languages": ["python-dev", "go-dev", "nodejs-dev"], "infrastructure": ["infrastructure-tools"]}'
```

Install everything:
```bash
	ansible-playbook playbook_dev-tools.yml -K -e '{"languages": ["python-dev", "go-dev", "rust-dev", "nodejs-dev"], "databases": ["postgresql", "redis", "sqlite"], "containers": ["container-podman"], "infrastructure": ["infrastructure-tools"], "linters": ["linters"]}'
```

---

## Package Details

### Common Development Tools (common-dev-tools group)
- "Version Control:" Git
- "Build Tools:" GNU Make, CMake, GCC, Clang, LLVM, pkg-config
- "Editors:" VSCodium, Neovim, Helix Editor

### Language Servers (language-servers group)
- "C/C++:" Clangd
- "Rust:" Rust Analyzer
- "Go:" gopls
- "Python:" Python LSP Server
- "TypeScript/JavaScript:" TypeScript Language Server

### Linters (linters group)
- "Python:" Black, Flake8, Mypy
- "JavaScript/TypeScript:" ESLint, Prettier

### Container Tools
- "Podman Group:" Podman, Buildah, Skopeo
- "Docker Group:" Docker, Docker Compose

### Infrastructure Tools
- "Kubernetes:" kubectl, Helm
- "Infrastructure as Code:" Terraform

### Language Environments

#### Python Development (python-dev group)
- "Core:" Python 3, pip, virtual environments, development headers
- "Testing:" Pytest
- "Database GUI:" DBeaver

#### Go Development (go-dev group)
- "Core:" Go compiler
- "Debugging:" Delve
- "Database GUI:" DBeaver

#### Rust Development (rust-dev group)
- "Toolchain:" Rustup, Cargo
- "Database GUI:" DBeaver

#### Node.js Development (nodejs-dev group)
- "Runtime:" Node.js, npm
- "Language:" TypeScript
- "Database GUI:" DBeaver

### Database Systems

#### PostgreSQL (postgresql group)
- "Server:" PostgreSQL
- "Client:" PostgreSQL client tools
- "GUI:" DBeaver

#### Redis (redis group)
- "Server:" Redis

#### SQLite (sqlite group)
- "Database:" SQLite
- "GUI:" DBeaver

---

## Common Tools Playbook

The `playbook_common-tools.yml` installs productivity and utility tools separately from development tools:

### Software Installed

| Tool | Description |
|------|-------------|
| "Fish Shell" | Smart and user-friendly command line shell |
| "LSDeluxe" | Modern `ls` command with icons and colors |
| "Bat" | `cat` clone with syntax highlighting and Git integration |
| "FiraCode" | Monospaced font with programming ligatures |
| "fzf" | General-purpose command-line fuzzy finder |
| "zoxide" | Smarter `cd` command that learns your habits |
| "duf" | Better `df` alternative for disk usage analysis |
| "Midnight Commander" | Classic visual file manager |
| "entr" | Runs arbitrary commands when files change |
| "tealdeer" | Fast, Rust-based client for `tldr` pages |
| "btop" | Modern and feature-rich resource monitor |
| "micro" | Modern and intuitive terminal-based text editor |
| "chezmoi" | Dotfile manager |
| "yay" | AUR Helper for Arch-based systems |
| "thefuck" | Corrects errors in previous console commands |
| "figlet" | Program for making large letters out of ordinary text |
| "cowsay" | Generates ASCII art pictures of a cow with a message |
| "fortune" | Displays random, often humorous, adages |
| "7zip" | File archiver with high compression ratio |

| Tool | Project Homepage | Description |
| :--- | :--- | :--- |
| **`anarchism`** | N/A | Exhaustive exploration of Anarchist theory and practice. |
| **`fish`** | [fishshell.com](https://fishshell.com/) | A smart and user-friendly command line shell. |
| **`lsd`** | [GitHub](https://github.com/Peltoche/lsd) | A modern `ls` command with lots of colors and icons. |
| **`bat`** | [GitHub](https://github.com/sharkdp/bat) | A `cat` clone with syntax highlighting and Git integration. |
| **`FiraCode`** | [GitHub](https://github.com/tonsky/FiraCode) | A monospaced font with programming ligatures. |
| **`fzf`** | [GitHub](https://github.com/junegunn/fzf) | A general-purpose command-line fuzzy finder. |
| **`zoxide`** | [GitHub](https://github.com/ajeetdsouza/zoxide) | A smarter `cd` command that learns your habits. |
| **`duf`** | [GitHub](https://github.com/muesli/duf) | A better `df` alternative for disk usage analysis. |
| **`mc`** | [midnight-commander.org](https://midnight-commander.org/) | A classic visual file manager (Midnight Commander). |
| **`entr`** | [eralabs.net/entr](http://eradman.com/entrproject/) | Runs arbitrary commands when files change. |
| **`tealdeer`** | [GitHub](https://github.com/dbrgn/tealdeer) | A fast, Rust-based client for `tldr` pages. |
| **`btop`** | [GitHub](https://github.com/aristocratos/btop) | A modern and feature-rich resource monitor. |
| **`micro`** | [micro-editor.github.io](https://micro-editor.github.io/) | A modern and intuitive terminal-based text editor. |
| **`chezmoi`** | [chezmoi.io](https://www.chezmoi.io/) | The dotfile manager used in the next stage. |
| **`yay`** | [GitHub](https://github.com/Jguer/yay) | An AUR Helper for Arch-based systems. |
| **`thefuck`** | [GitHub](https://github.com/nvbn/thefuck) | A magnificent app that corrects errors in previous console commands.
| **`figlet`** | [figlet.org](http://www.figlet.org/) | A program for making large letters out of ordinary text. |
| **`cowsay`** | [Wikipedia](https://en.wikipedia.org/wiki/Cowsay) | A program that generates ASCII art pictures of a cow with a message. |
| **`fortune`** | N/A | A program that displays a random, often humorous, adage. |
| **`7zip`** | [7Zip](https://7-zip.org/support.html) | A file archiver with a high compression ratio. |

---

## Important Notes

### Duplicate Package Handling
The playbook automatically handles packages that appear in multiple selected groups. Each package is installed only once, regardless of how many groups reference it.

### Language Server Support for Kate
When you install the `language-servers` group, to use them with Kate:

1. Open Kate
2. Go to Settings '->' Configure Kate '->' Plugins
3. Enable "LSP Client" plugin
4. Restart Kate
5. Go to Settings '->' Configure Kate '->' LSP Client
6. The installed language servers should auto-configure for supported file types

### Platform Support
- "Debian/Ubuntu:" All packages from official repositories
- "Fedora/RedHat:" All packages from official repositories
- "Arch Linux:" Official packages + AUR packages via dedicated `aur_builder` user

### AUR Package Support
For Arch Linux, the playbook creates a dedicated `aur_builder` user that handles AUR package installations securely without requiring password prompts for pacman.

### Error Handling
The playbook provides detailed error messages for failed package installations, including:
- Package name and description
- Installer used
- Specific error messages

Failed package installations don't stop the entire process - they're reported with detailed information for troubleshooting.

---

## Directory Structure

Creates an organized development workspace:
```
	~/dev/
	├── python/
	├── go/
	├── rust/
	├── js/
	├── dotnet/
	├── docker/
	└── databases/
```

---

## Troubleshooting

### Package Installation Failures
Check the detailed error messages that include:
- Package name and description
- Installer used (OS, pip, cargo, npm)
- Specific error details

### AUR Build Issues
- Ensure the `aur_builder` user exists (created by `playbook_ansible-dependencies.yml`)
- Check disk space in `/tmp` for AUR builds

### Language Server Configuration
- Most editors auto-detect language servers
- For Kate, ensure LSP Client plugin is enabled
- Restart your editor after installing language servers

### Re-running Playbooks
Playbooks are idempotent - they can be safely re-run to complete any failed installations or update existing packages.
