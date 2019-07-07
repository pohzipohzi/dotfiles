mkdir -p $DOTFILES/.tmp
d=$DOTFILES/.tmp
cd $d # ensure that we clone directories to the right place

# ccls
if cd $d/ccls; then git pull; else git clone --depth=1 --recursive https://github.com/MaskRay/ccls; fi
cd $d/ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx
cmake --build Release --target install

