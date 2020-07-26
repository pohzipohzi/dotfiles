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
# linux
ln -s $DOTFILES/.bash_aliases $HOME/.bash_aliases
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.ideavimrc $HOME/.ideavimrc
ln -s -d $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s -d $DOTFILES/.config/i3 $HOME/.config/i3
ln -s -d $DOTFILES/.config/alacritty $HOME/.config/alacritty
ln -s -d $DOTFILES/.config/git $HOME/.config/git
source ~/.bashrc

# mac
ln -s $DOTFILES/.bash_aliases $HOME/.bash_aliases
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.ideavimrc $HOME/.ideavimrc
ln -s $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s $DOTFILES/.config/alacritty $HOME/.config/alacritty
ln -s $DOTFILES/.config/git $HOME/.config/git
source ~/.bashrc
```
