# dotfiles

Some personal dotfiles to be used across machines.

First clone into `$HOME`:

```sh
git clone git@github.com:pohzipohzi/dotfiles.git $HOME/dotfiles
```

Next extend `.bashrc`:

```sh
echo "export DOTFILES=$HOME/dotfiles/dotfiles" >> $HOME/.bashrc
echo "[ -f $HOME/.bashrc_aliases ] && source $HOME/.bashrc_aliases" >> $HOME/.bashrc
source ~/.bashrc
```

Then symlink everything:

```sh
# linux
ln -s $DOTFILES/.bashrc_aliases $HOME/.bashrc_aliases
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s -d $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s -d $DOTFILES/.config/i3 $HOME/.config/i3
source ~/.bashrc

# mac
ln -s $DOTFILES/.bashrc_aliases $HOME/.bashrc_aliases
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s $DOTFILES/.ideavimrc $HOME/.ideavimrc
source ~/.bashrc
```
