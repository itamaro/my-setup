#!/bin/bash

echo "Install Homebrew"
# https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap \
    caskroom/cask \
    heroku/brew \
    homebrew/python \
    homebrew/science \
    homebrew/x11
