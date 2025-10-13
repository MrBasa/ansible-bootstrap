#!/usr/bin/env bash
#
# set_sudoers.sh
#
# Adds or removes a sudoers file allowing a user to run pacman without a password.
# This is a common requirement for Ansible automation on Arch Linux.
#
# Defaults to the user who invoked sudo if <username> is omitted.
#

set -o errexit  # Exit immediately if a command exits with a non-zero status.
set -o nounset  # Treat unset variables as an error when substituting.
set -o pipefail # Return the exit status of the last command in a pipeline that failed.

# --- Help Function ---
display_help() {
    echo "Usage: sudo $0 [COMMAND] [<username>]"
    echo
    echo "This script manages a sudoers file to allow passwordless pacman execution for a user."
    echo
    echo "Commands:"
    echo "  add      Adds the sudoers rule for the specified or current user."
    echo "  remove   Removes the sudoers rule for the specified or current user."
    echo "  -h, --help  Display this help message and exit."
    echo
    echo "The <username> argument is optional. If omitted, the script defaults to the user"
    echo "who invoked the sudo command (\$SUDO_USER)."
}

# --- Argument Check ---
if [[ "$#" -eq 0 ]]; then
    display_help
    exit 1
fi

# --- Main Logic ---
case "$1" in
    -h | --help)
        display_help
        exit 0
        ;;
esac

# At this point, we expect 'add' or 'remove' as the first argument.
ACTION=$1
TARGET_USER=${2:-$SUDO_USER}
SUDOERS_FILE="/etc/sudoers.d/10-ansible-pacman-for-${TARGET_USER}"

# Final check to ensure we have a target user
if [[ -z "$TARGET_USER" ]]; then
    echo "Error: Could not determine target user." >&2
    echo "Please specify a username or run with a standard sudo session." >&2
    exit 1
fi

# Ensure the script is run as root for file operations
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root. Please use sudo." >&2
   exit 1
fi

case "$ACTION" in
    add)
        echo "-> Adding passwordless pacman access for user: ${TARGET_USER}"
        echo "${TARGET_USER} ALL=(ALL) NOPASSWD: /usr/bin/pacman" > "${SUDOERS_FILE}"
        chmod 440 "${SUDOERS_FILE}"
        echo "-> Successfully created ${SUDOERS_FILE}"
        ;;

    remove)
        echo "-> Removing passwordless pacman access for user: ${TARGET_USER}"
        if [[ -f "${SUDOERS_FILE}" ]]; then
            rm -f "${SUDOERS_FILE}"
            echo "-> Successfully removed ${SUDOERS_FILE}"
        else
            echo "-> File not found. Nothing to remove."
        fi
        ;;

    *)
        echo "Error: Invalid command '${ACTION}'." >&2
        display_help
        exit 1
        ;;
esac
