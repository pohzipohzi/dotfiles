# see https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt autoremove
    sudo apt update
    sudo apt upgrade
    vim +'PlugUpdate --sync' +qa
elif [[ "$OSTYPE" == "darwin"* ]]; then
    :
fi
