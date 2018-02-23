#!/bin/bash
# Script for keeping existing Mac up to date (IDEMPOTENT!)

if [ "$( uname -s )" != "Darwin" ]; then
    echo "Not running on OS X!" 1>&2
    exit 1
fi

echo "Update Homrbrew"
brew update

./osx-config.sh
./quick-idempotent-mac-setup.sh
