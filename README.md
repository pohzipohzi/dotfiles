# dotfiles

Some personal dotfiles to be used across machines.

First clone into `$HOME`:

```sh
git clone git@github.com:pohzipohzi/dotfiles.git $HOME/dotfiles
```

Next extend `.bashrc`:

```sh
echo "export DOTFILES=$HOME/dotfiles/dotfiles" >> $HOME/.bashrc
echo "[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc
source ~/.bashrc
```

Then symlink everything:

```sh
ln -s $DOTFILES/.bashrc_aliases $HOME/.bashrc_aliases
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s -d $DOTFILES/.config/nvim $HOME/.config/nvim
source ~/.bashrc
```
