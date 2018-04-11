#!/bin/bash
# Initial set up script for a new clean Mac

if [ "$( uname -s )" != "Darwin" ]; then
    echo "Not running on OS X!" 1>&2
    exit 1
fi

brew_taps=(
    caskroom/cask
    heroku/brew
    homebrew/dupes
    homebrew/python
    homebrew/science
    homebrew/x11
)

brew_formulae=(
    ack
    bash
    bazel
    brew-cask-completion
    bash-completion
    bash-git-prompt
    coreutils
    caskroom/cask/brew-cask
    curl
    docker-completion
    docker-compose
    docker-compose-completion
    dos2unix
    findutils
    firebase-cli
    gcc
    git
    git-lfs
    go
    godep
    graphviz
    grpc
    heroku
    homebrew/dupes/grep
    hugo
    imagemagick
    jq
    kubernetes-cli
    kubernetes-helm
    maven
    nano
    node
    npm
    octave
    p7zip
    protobuf
    python
    python@2
    rename
    ruby
    rust
    socat
    sqlite
    ssh-copy-id
    telepresence
    travis
    tree
    unrar
    vim
    watch
    wget
    wrk
    yarn
)

brew_casks=(
    android-studio
    bartender
    caffeine
    crashplan
    docker
    dropbox
    evernote
    firefox
    flux
    gimp
    google-chrome
    handbrake
    iterm2
    java
    karabiner
    lastpass
    mactex
    ngrok
    nvalt
    pandoc
    pdfpenpro
    sizeup
    skitch
    sourcetree
    sublime-text
    synergy
    the-unarchiver
    ticktick
    transmit
    tunnelblick
    vagrant
    virtualbox
    vlc
    wavebox
    wireshark
    xquartz
)

echo "Install Homebrew"
# https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap ${brew_taps[@]}

echo "Install packages using Homebrew"
brew install ${brew_formulae[@]}

echo "Install casks using Homebrew Cask"
brew cask install ${brew_casks[@]}

brew cask cleanup

./osx-config.sh
