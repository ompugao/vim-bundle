# Installation

````
git clone https://github.com/ompugao/vim-bundle $HOME/.vim
cd $HOME/.vim
git submodule update --init
cd bundle/vimproc && make
cd -
ln -s $HOME/.vim/.vimrc $HOME/.vimrc
ln -s $HOME/.vim/.gvimrc $HOME/.gvimrc
ln -s $HOME/.vim/.ctags $HOME/.ctags
````
