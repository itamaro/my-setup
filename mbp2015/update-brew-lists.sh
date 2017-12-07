#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

BASE_DIR="$( get_script_dir )"
cd $BASE_DIR

echo "Save versions of installed Homebrew & Cask"
brew --version > homebrew.version
brew cask --version > homebrew.cask.version

echo "Save all tapped Homebrew taps"
brew tap > homebrew.taps

echo "Save all installed Homebrew formulae"
brew list --full-name --versions | sort > homebrew.list

echo "Save all installed brew Casks"
brew cask list --versions --full-name | sort > homebrew.cask.list
