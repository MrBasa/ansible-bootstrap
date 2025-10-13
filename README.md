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

Runs the playbooks as your user and handles privilege escalation.

### Step 1: Install Dependencies & Clone Repo

**On all systems:**
```bash
# Install Ansible and Git
sudo apt update && sudo apt install -y ansible-core git  # For Debian/Ubuntu
sudo dnf install -y ansible-core git                     # For Fedora
sudo pacman -Syu --needed ansible-core git               # For Arch

# Clone this repository
git clone [https://github.com/mrbasa/ansible-bootstrap.git](https://github.com/mrbasa/ansible-bootstrap.git)
cd ansible-bootstrap
```

### Step 2: Prepare for AUR (Arch Linux Only)
If you are on Arch Linux or an Arch-based distro, you must enable passwordless `sudo` for your user to allow for non-interactive AUR package installation.

```bash
# (Run from inside the cloned repository directory)
sudo ./set_sudoers.sh add
```

### Step 3: Run the Playbooks
You will be prompted for your `sudo` password once at the beginning of each playbook run.

```bash
# Run the collection bootstrapper
ansible-playbook --ask-become-pass bootstrap-ansible.yml

# Run the main utilities installer
ansible-playbook --ask-become-pass core-utilities.yml
```

### Step 4: Cleanup (Arch Linux Only)
After the playbooks have successfully completed, it is recommended to remove the passwordless `sudo` rule.
```bash
sudo ./set_sudoers.sh remove
```
