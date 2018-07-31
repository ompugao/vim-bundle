# Installation

````
git clone https://github.com/ompugao/vim-bundle $HOME/.vim
cd $HOME/.vim
git submodule update --init
cd bundle/vimproc && make
cd -
ln -s $HOME/.vim/.ctags $HOME/.ctags   # for exuberant-ctags
mkdir -p $HOME/.ctags.d && ln -s $HOME/.vim/.ctags $HOME/.ctags.d/default.ctags # for universal-ctags
````
