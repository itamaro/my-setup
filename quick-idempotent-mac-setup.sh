#!/bin/bash
# Script for keeping existing Mac up to date (IDEMPOTENT & FAST)

if [ "$( uname -s )" != "Darwin" ]; then
    echo "Not running on OS X!" 1>&2
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$SCRIPT_DIR/.backup"

if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

install_dotfile() {
  src="$1"
  dst="$2"
  dst_dir="$( dirname $dst )"
  if [ "$src" != "$( readlink $dst )" ]; then
    if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
      echo "Moving existing $dst to $BACKUP_DIR"
      mv "$dst" "$BACKUP_DIR"
    fi
    if [ ! -d "$dst_dir" ]; then
      mkdir -p "$dst_dir"
    fi
    echo "Installing $dst from dotfiles"
    ln -s "$src" "$dst"
  fi
}

echo "Setting up dotfiles from $DOTFILES"
DOTFILES="$SCRIPT_DIR/dotfiles"
# Ansible
install_dotfile "$DOTFILES/.ansible.cfg" "$HOME/.ansible.cfg"
# bash / bin
install_dotfile "$DOTFILES/.profile.d" "$HOME/.profile.d"
