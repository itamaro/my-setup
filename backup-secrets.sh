#!/bin/bash
# Script for keeping existing Mac up to date (IDEMPOTENT & FAST)

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
