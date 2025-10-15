# Ansible Bootstrap

This repository contains Ansible playbooks to bootstrap a new Linux machine (Debian, Fedora, or Arch-based). It installs a common set of development tools and prepares the system for personal dotfile management with Chezmoi.

---

## Software Installed

This playbook installs the following software:

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

## Usage on a New Machine

This is the final, simplified method that runs the playbooks as your user and handles privilege escalation correctly. **No special `sudoers` files are required.**

### Step 1: Install Dependencies & Clone Repo

**On all systems:**
```bash
# Install Ansible and Git
sudo apt update && sudo apt install -y ansible-core git  # For Debian/Ubuntu
sudo dnf install -y ansible-core git                     # For Fedora
sudo pacman -Syu --needed ansible-core git base-devel    # For Arch

# Clone this repository
git clone [https://github.com/mrbasa/ansible-bootstrap.git](https://github.com/mrbasa/ansible-bootstrap.git)
cd ansible-bootstrap
```
*Note for Arch: The `base-devel` package group is required to build AUR packages.*

### Step 2: Run the Playbooks
You will be prompted for your `sudo` password at the beginning of each playbook run. This password is then used by Ansible for any tasks that require root privileges.

```bash
curl -sSL https://raw.githubusercontent.com/mrbasa/ansible-bootstrap/main/bootstrap.sh | bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, bootstrap-ansible-pull.yml -K
```
---
' Development Environment Playbook

An optional Ansible playbook to set up a customizable development environment after the core system bootstrap. Only installs what you need.

## Quick Start

### Run with only common development tools (default)
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K
'''

### Run with specific languages
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]languages=['python','go','rust'][double_quote]
'''

### Run with specific databases
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]databases=['postgresql','redis'][double_quote]
'''

### Full custom installation
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]languages=['python','nodejs'] databases=['postgresql'] ides=['vscodium'][double_quote]
'''

## Configuration Options

### Method 1: Command Line Variables

#### Install Python, Go, and Rust
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]languages=['python','go','rust'][double_quote]
'''

#### Install with specific databases
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]databases=['postgresql','redis'][double_quote]
'''

#### Install specific IDEs
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]ides=['vscodium','neovim'][double_quote]
'''

#### Version pinning
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]python_version=3.11 node_version=20[double_quote]
'''

### Method 2: Configuration File

Create 'dev-config.yml':
'''yaml
languages:
  - python
  - go
  - nodejs
databases:
  - postgresql
  - redis
ides:
  - vscodium
  - neovim
python_version: [double_quote]3.11[double_quote]
node_version: [double_quote]20[double_quote]
'''

Then run:
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --extra-vars [double_quote]@dev-config.yml[double_quote]
'''

## Available Components

### Languages ('languages')

| Language | Packages Included | Version Default |
|----------|-------------------|-----------------|
| 'python' | Python 3, pip, venv, pipx, poetry, pytest, black, flake8, mypy, pylint, jupyter, ipython | Latest stable |
| 'go' | Go compiler, gopls, delve, golangci-lint, richgo, staticcheck | Latest stable |
| 'nodejs' | Node.js, npm, yarn, pnpm, typescript, eslint, prettier, nodemon, ts-node | LTS |
| 'rust' | Rust toolchain (rustup, cargo), rust-analyzer, clippy, rustfmt | Stable |
| 'java' | OpenJDK, Maven, Gradle, Groovy | Latest LTS |
| 'dotnet' | .NET SDK, ASP.NET Core runtime | Latest LTS |

### Databases ('databases')

| Database | Packages Included |
|----------|-------------------|
| 'postgresql' | PostgreSQL server, client, libpq, pgAdmin |
| 'mysql' | MySQL server, client, MySQL Workbench |
| 'sqlite' | SQLite, SQLite browser, SQLite utilities |
| 'redis' | Redis server, redis-tools, redis-cli |
| 'mongodb' | MongoDB server, mongosh, MongoDB Compass |

### IDEs & Editors ('ides')

| IDE/Editor | Packages Included |
|------------|-------------------|
| 'vscodium' | VSCodium (FOSS VS Code) with core extensions |
| 'neovim' | Neovim with LSP support |
| 'vim' | Vim with common plugins |
| 'emacs' | Emacs with common packages |
| 'jetbrains' | JetBrains Toolbox (AUR) |

## What Gets Installed by Default

### Common Development Tools (Always Installed)
- **Build Tools**: make, cmake, ninja, gcc, g++, clang, llvm, pkg-config
- **Version Control**: git (with sensible defaults)
- **Code Analysis**: shellcheck, shfmt, universal-ctags, global, bear
- **Containers**: docker, docker-compose, podman
- **Cloud Tools**: kubectl, helm, terraform, aws-cli
- **Editors**: micro, helix (modern terminal editors)
- **Utilities**: jq, yq, htop, fzf, ripgrep, fd-find, bat, exa, dust

### Language-Specific Additions

When you opt into a language, you get:
- **Core runtime/compiler**
- **Package manager**
- **Language server** (LSP)
- **Debugger**
- **Formatter & linter**
- **Testing framework**
- **Popular development tools**

### Database-Specific Additions

When you opt into a database, you get:
- **Database server** (if applicable)
- **Command-line client**
- **Development libraries**
- **GUI tools** (where available)

## Package Inventory

### Common Development Packages
- **Build System**: 'make', 'cmake', 'ninja', 'autoconf', 'automake', 'libtool'
- **Compilers**: 'gcc', 'g++', 'clang', 'llvm', 'lldb'
- **Code Tools**: 'shellcheck', 'shfmt', 'universal-ctags', 'global', 'bear', 'codespell'
- **Containers**: 'docker', 'docker-compose', 'podman', 'buildah', 'skopeo'
- **Cloud Native**: 'kubectl', 'helm', 'terraform', 'aws-cli', 'google-cloud-sdk'
- **Terminal Utilities**: 'jq', 'yq', 'htop', 'fzf', 'ripgrep', 'fd-find', 'bat', 'exa', 'dust', 'zoxide'
- **Editors**: 'micro', 'helix'

### Language Packages

#### Python
- **Core**: 'python3', 'python3-pip', 'python3-venv', 'python3-dev'
- **Package Management**: 'pipx', 'poetry'
- **Development**: 'pytest', 'black', 'flake8', 'mypy', 'pylint', 'isort', 'bandit', 'safety'
- **Interactive**: 'ipython', 'jupyter', 'jupyterlab'
- **Runtime Management**: 'pyenv'

#### Go
- **Core**: 'go', 'gopls'
- **Development**: 'delve', 'golangci-lint', 'richgo', 'staticcheck'

#### Node.js
- **Core**: 'nodejs', 'npm', 'yarn', 'pnpm'
- **Development**: 'typescript', 'eslint', 'prettier', 'nodemon', 'ts-node'
- **Frameworks**: '@vue/cli', 'create-react-app', '@angular/cli'
- **Runtime Management**: 'nvm'

#### Rust
- **Core**: 'rustup', 'cargo', 'rustc'
- **Development**: 'rust-analyzer', 'clippy', 'rustfmt', 'cargo-watch'
- **Tools**: Popular Rust development utilities

#### Java
- **Core**: 'jdk-openjdk', 'maven', 'gradle'
- **Languages**: 'groovy', 'kotlin'
- **Tools**: 'spring-boot-cli'

#### .NET
- **Core**: 'dotnet-sdk', 'aspnetcore-runtime'
- **Tools**: 'dotnet-tools'

### Database Packages

#### PostgreSQL
- **Server**: 'postgresql', 'postgresql-libs'
- **Client**: 'postgresql-client', 'libpq-dev'
- **GUI**: 'pgadmin4'

#### MySQL
- **Server**: 'mysql', 'mysql-server'
- **Client**: 'mysql-client', 'libmysqlclient-dev'
- **GUI**: 'mysql-workbench'

#### SQLite
- **Core**: 'sqlite', 'sqlite3'
- **Tools**: 'sqlitebrowser', 'sqlite-utils'

#### Redis
- **Server**: 'redis', 'redis-server'
- **Client**: 'redis-tools', 'redis-cli'

#### MongoDB
- **Server**: 'mongodb', 'mongodb-server'
- **Client**: 'mongosh', 'mongo-tools'
- **GUI**: 'mongodb-compass'

### IDE Packages

#### VSCodium
- **Core**: 'vscodium'
- **Extensions**: Python, Go, Rust, TypeScript, Docker, GitLens, YAML, Markdown

#### Neovim
- **Core**: 'neovim'
- **LSP**: Language Server Protocol support

#### Vim
- **Core**: 'vim', 'vim-gtk' (for clipboard support)

#### Emacs
- **Core**: 'emacs', 'emacs-nox'

#### JetBrains
- **Tool**: 'jetbrains-toolbox' (AUR)

## Platform Support

- **Debian/Ubuntu**: All packages from official repositories
- **Fedora**: All packages from official repositories  
- **Arch Linux**: Official packages + AUR packages via yay

## Directory Structure

Creates an organized workspace:
'''
~/dev/
├── python/
├── go/
├── rust/
├── js/
├── dotnet/
├── docker/
└── databases/
'''

## Requirements

- Must be run after core bootstrap playbook
- Requires sudo access
- Internet connection for package downloads

## Troubleshooting

### Tags for Selective Execution

#### Install only common tools
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --tags common
'''

#### Install only Python environment
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --tags python
'''

#### Install only databases
'''bash
ansible-pull -U https://github.com/mrbasa/ansible-bootstrap.git -i localhost, dev-environment.yml -K --tags databases
'''

### Potential Issues

- **AUR packages**: Ensure 'aur_builder' user exists from core bootstrap
- **Disk space**: Full installation requires significant space
- **Network timeouts**: Re-run playbook if downloads fail
