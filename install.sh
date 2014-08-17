#!/bin/sh

set -

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
    brew install git

    cd $HOME
    git clone git@bitbucket.org:sudarkoff/bin.git

    cd $HOME
    git clone https://github.com/sudarkoff/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"

    [ "$1" == "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
