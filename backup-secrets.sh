#!/bin/bash
# Script for encrypting and backing up secrets

if [ "$( uname -s )" != "Darwin" ]; then
    echo "Not running on OS X!" 1>&2
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -n "Enter password for secrets encryption: "
read -s ENC_PASS
echo ""

encrypt_file() {
  src="$1"
  dst="$2"
  dst_dir="$( dirname $dst )"
  if [ ! -d "$dst_dir" ]; then
    mkdir -p "$dst_dir"
  fi
  openssl aes-256-cbc -salt -a -e -in "$src" -out "$dst" -pass pass:$ENC_PASS
}


echo "Backing up SSH private keys"
SECRET="$HOME/Dropbox/Mackup"
# SSH (private keys)
encrypt_file "$HOME/.ssh/id_rsa" "$SECRET/.ssh/id_rsa.enc"
encrypt_file "$HOME/.ssh/id_me_rsa" "$SECRET/.ssh/id_me_rsa.enc"
encrypt_file "$HOME/.ssh/id_rsa_crs" "$SECRET/.ssh/id_rsa_crs.enc"
