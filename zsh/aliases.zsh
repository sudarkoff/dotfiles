# Aliases in this file are bash and zsh compatible

# Don't change. The following determines where YADR is installed.
yadr=$HOME/.yadr

# YADR support
alias yav='yadr vim-add-plugin'
alias ydv='yadr vim-delete-plugin'
alias ylv='yadr vim-list-plugin'
alias yup='yadr update-plugins'
alias yip='yadr init-plugins'

# Show human friendly numbers and colors
alias l='ls -alGh'
alias ls='ls -Gh'
alias df='df -h'
alias du='du -h -d 2'

# Alias Editing
alias ae='vim $yadr/zsh/aliases.zsh' #alias edit
alias ar='source $yadr/zsh/aliases.zsh'  #alias reload

# vimrc editing
alias ve='vim ~/.vimrc'

# zsh profile editing
alias ze='vim ~/.zshrc'
alias zr='source ~/.zshrc'

# Git Aliases
alias gc='git commit -m'
alias gs='git status'
alias ga='git add -A'
alias gp='git pull'
alias gr='git rebase'
alias gd='git diff'

# Common shell functions
alias less='less -r'

# Zippin
alias gz='tar -zcvf'
alias ungz='tar -zxvf'

# Various
alias sel='source $HOME/bin/selectWorkspace.sh $*'
alias bora='cd $VMTREE'
alias la='$HOME/bin/log add'
alias ll='$HOME/bin/log list'

