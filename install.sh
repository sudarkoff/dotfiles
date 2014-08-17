#!/bin/sh

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"

    # TODO: Check and install prerequisites
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
    brew install git

    git clone https://github.com/sudarkoff/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"

    [ "$1" == "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
