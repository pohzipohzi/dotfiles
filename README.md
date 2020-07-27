# dotfiles

Some personal dotfiles to be used across machines.

First clone into `$HOME`:

```sh
git clone git@github.com:pohzipohzi/dotfiles.git $HOME/dotfiles
```

Export `DOTFILES` as an environment variable:

```sh
export DOTFILES=$HOME/dotfiles/dotfiles
```

Then symlink everything:

```sh
# linux
ln -s $DOTFILES/.bashrc $HOME/.bashrc
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.ideavimrc $HOME/.ideavimrc
ln -s $DOTFILES/.xinitrc $HOME/.xinitrc
ln -s -d $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s -d $DOTFILES/.config/alacritty $HOME/.config/alacritty
ln -s -d $DOTFILES/.config/git $HOME/.config/git
source ~/.bashrc

# mac
ln -s $DOTFILES/.bashrc $HOME/.bashrc
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.ideavimrc $HOME/.ideavimrc
ln -s $DOTFILES/.config/nvim $HOME/.config/nvim
ln -s $DOTFILES/.config/alacritty $HOME/.config/alacritty
ln -s $DOTFILES/.config/git $HOME/.config/git
source ~/.bashrc
```
