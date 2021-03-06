# terminal
export PS1="\[\e[01;34m\]\w$\[\e[m\] "
export TERM="screen-256color"
export VISUAL=nvim
export EDITOR="$VISUAL"
alias tmux="tmux -2"

# bat
export BAT_THEME="Nord"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# aws
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli:2.1.4'

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$(go env GOPATH)/bin
export PATH=$PATH:$GOBIN

# python
export PATH=$PATH:$(python -m site --user-base)/bin

# node
source /usr/share/nvm/init-nvm.sh

# ruby
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
eval "$(rbenv init -)"

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
