# see https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt autoremove
    sudo apt update
    sudo apt upgrade
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew upgrade # upgrade also runs update
fi

nvim +'PlugUpdate --sync' +qa
