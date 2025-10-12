# Ansible Bootstrap

This repository contains an Ansible playbook to bootstrap a new Linux machine (Debian, Fedora, or Arch-based). It installs a common set of development tools and prepares the system for personal dotfile management with Chezmoi.

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
---

## Usage on a New Machine

This is the first step in setting up a new environment. Run the appropriate command for your OS to install the dependencies, then run the `ansible-pull` command to execute the playbook.

### Step 1: Install Dependencies

**On Debian/Ubuntu:**
```bash
sudo apt update && sudo apt install -y ansible-core git
```

**On Fedora:**
```bash
sudo dnf install -y ansible-core git
```

**On Arch Linux / EndeavourOS:**
```bash
sudo pacman -Syu --needed ansible-core git
```

### Step 2: Run the Playbook

This command is the same for all systems. It pulls the playbook from this repository and runs it locally to configure your system.

**Important:** Replace `your-username` with your actual GitHub username.

```bash
sudo ansible-pull -U [https://github.com/your-username/ansible-bootstrap.git](https://github.com/your-username/ansible-bootstrap.git)
```
