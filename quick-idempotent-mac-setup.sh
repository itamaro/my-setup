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
# Git
install_dotfile "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
install_dotfile "$DOTFILES/.gitignore_global" "$HOME/.gitignore_global"
# nano
install_dotfile "$DOTFILES/.nanorc" "$HOME/.nanorc"
install_dotfile "$DOTFILES/.nano" "$HOME/.nano"
# vim
install_dotfile "$DOTFILES/.vimrc" "$HOME/.vimrc"

SENSITIVE="$HOME/Dropbox/Mackup"
echo "Setting up sensitive dotfiles from $SENSITIVE"
# SSH (configs, public keys, NOT private keys! (see "backup/restore secrets"))
install_dotfile "$SENSITIVE/.ssh/config" "$HOME/.ssh/config"
install_dotfile "$SENSITIVE/.ssh/known_hosts" "$HOME/.ssh/known_hosts"
install_dotfile "$SENSITIVE/.ssh/google_compute_known_hosts" "$HOME/.ssh/google_compute_known_hosts"
install_dotfile "$SENSITIVE/.ssh/id_rsa.pub" "$HOME/.ssh/id_rsa.pub"
install_dotfile "$SENSITIVE/.ssh/id_me_rsa.pub" "$HOME/.ssh/id_me_rsa.pub"
install_dotfile "$SENSITIVE/.ssh/id_rsa_crs.pub" "$HOME/.ssh/id_rsa_crs.pub"
install_dotfile "$SENSITIVE/.ssh/id_rsa_github.pub" "$HOME/.ssh/id_rsa_github.pub"
install_dotfile "$SENSITIVE/.ssh/itamaro.pub" "$HOME/.ssh/itamaro.pub"
install_dotfile "$SENSITIVE/.ssh/google_compute_engine.pub" "$HOME/.ssh/google_compute_engine.pub"
# AWS (config, NOT credentials (see "backup/restore secrets"))
install_dotfile "$SENSITIVE/.aws/config" "$HOME/.aws/config"
