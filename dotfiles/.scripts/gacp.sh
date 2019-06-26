if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

cd $DOTFILES
git add .
git commit -m "$1"
git push
