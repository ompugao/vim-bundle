#!/bin/bash
cd $HOME/.vim/
git submodule -q foreach 'echo $path' | xargs -I{} -P 4 bash -c 'echo {} && git submodule update --init {}'
