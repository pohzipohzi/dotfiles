# dotfiles
export DOTFILES=$HOME/dotfiles
alias b="bash $DOTFILES/.scripts/ba.sh"

# terminal
export PS1="\e[01;34m\w$\e[m "
export TERM="screen-256color"
export VISUAL=nvim
export EDITOR="$VISUAL"
alias tmux="tmux -2"

# go
export GOPATH=$HOME/go
export GOBIN=$(go env GOPATH)/bin
export PATH=$PATH:$GOBIN

# separate bashrc for work
[ -f $HOME/.bashrc2 ] && source $HOME/.bashrc2
