set -o vi

### Picks a platform-appropriate vi
function pick-vi () {
    if [ -f "$HOME/bin/$OSTYPE/mvim" ]; then
        echo "$HOME/bin/$OSTYPE/mvim"
    elif [ -f "/usr/bin/vim" ]; then
        echo "/usr/bin/vim"
    elif [ -f "/usr/bin/vi" ]; then
        echo "/usr/bin/vi"
    elif [ -f "/bin/vi" ]; then
        echo "/bin/vi"
    fi
}

export VI="$(pick-vi)"
export EDITOR="${VI:-vim}"
export VISUAL="${VI:-vim} -f"

