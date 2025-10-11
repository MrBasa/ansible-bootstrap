# Ansible Bootstrap

This repository contains an Ansible playbook to bootstrap a new Linux machine (Debian, Fedora, or Arch-based). It installs a common set of development tools and prepares the system for personal dotfile management with Chezmoi.



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
