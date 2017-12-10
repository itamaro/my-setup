#!/bin/bash

echo "Save versions of installed Homebrew & Cask"
brew --version > homebrew.version
brew cask --version > homebrew.cask.version

echo "Save all tapped Homebrew taps"
brew tap > homebrew.taps

echo "Save all installed Homebrew formulae"
brew list --full-name --versions | sort > homebrew.list

echo "Save all installed brew Casks"
brew cask list --versions --full-name | sort > homebrew.cask.list
