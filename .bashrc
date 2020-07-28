# terminal
export PS1="\e[01;34m\w$\e[m "
export TERM="screen-256color"
export VISUAL=nvim
export EDITOR="$VISUAL"
alias tmux="tmux -2"

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$(go env GOPATH)/bin
export PATH=$PATH:$GOBIN

# dotfiles
export DOTFILES=$HOME/dotfiles
alias b="bash $DOTFILES/.scripts/ba.sh"
[ -f $HOME/.bashrc2 ] && source $HOME/.bashrc2
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
