# Installation

```bash
git clone https://github.com/ompugao/vim-bundle $HOME/.vim
ln -s $HOME/.vim/.ctags $HOME/.ctags   # for exuberant-ctags
mkdir -p $HOME/.ctags.d && ln -s $HOME/.vim/.ctags $HOME/.ctags.d/default.ctags # for universal-ctags
# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh
cat <<EOF >> ~/.bashrc
export DENO_INSTALL="/home/leus/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
EOF
```
