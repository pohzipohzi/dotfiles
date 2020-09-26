# terminal
export PS1="\[\e[01;34m\]\w$\[\e[m\] "
export TERM="screen-256color"
export VISUAL=nvim
export EDITOR="$VISUAL"
alias tmux="tmux -2"

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$(go env GOPATH)/bin
export PATH=$PATH:$GOBIN

# postgres
export PSQL_PAGER='less -S'

# keyboard
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    setxkbmap -option caps:swapescape
fi

# dotfiles
export PATH=$PATH:$HOME/dotfiles/.scripts
[ -f $HOME/.bashrc2 ] && source $HOME/.bashrc2
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
