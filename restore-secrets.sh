#!/bin/bash
# Script for decrypting and restoring secrets

if [ "$( uname -s )" != "Darwin" ]; then
    echo "Not running on OS X!" 1>&2
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -n "Enter password for secrets encryption: "
read -s ENC_PASS

decrypt_file() {
  dst="$1"
  src="$2"
  dst_dir="$( dirname $dst )"
  if [ ! -d "$dst_dir" ]; then
    mkdir -p "$dst_dir"
  fi
  openssl aes-256-cbc -salt -a -d -in "$src" -out "$dst" -pass pass:$ENC_PASS
  chmod 400 "$dst"
}

echo "Restoring SSH private keys"
SECRET="$HOME/Dropbox/Mackup"
# SSH (private keys)
decrypt_file "$HOME/.ssh/id_rsa" "$SECRET/.ssh/id_rsa.enc"
decrypt_file "$HOME/.ssh/id_me_rsa" "$SECRET/.ssh/id_me_rsa.enc"
decrypt_file "$HOME/.ssh/id_rsa_crs" "$SECRET/.ssh/id_rsa_crs.enc"
decrypt_file "$HOME/.ssh/id_rsa_github" "$SECRET/.ssh/id_rsa_github.enc"
