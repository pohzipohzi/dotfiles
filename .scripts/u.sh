if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo pacman -Syyu
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew upgrade
fi

nvim +'PlugUpdate --sync' +qa
