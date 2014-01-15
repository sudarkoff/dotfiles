# Initialize user's ~/bin environment if present
#
if [ -d $HOME/bin/ ]; then
  if [ "$(ls -A $HOME/bin/init.zsh)" ]; then
    source $HOME/bin/init.zsh
  fi
fi

