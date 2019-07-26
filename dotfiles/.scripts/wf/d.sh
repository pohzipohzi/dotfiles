if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo dfu-util -D $DOTFILES/.whitefox/linux.bin
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sudo dfu-util -D $DOTFILES/.whitefox/mac.bin
fi
