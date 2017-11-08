#/bin/bash
cd $HOME/.vim/
#find . -depth 1 -type d | xargs -I{} -P 4 bash -c '[ -e {}/.git ] && echo {} && cd {} && git pull'
git submodule -q foreach 'echo $path' | xargs -I{} -P 4 bash -c 'cd {} && git checkout master && git pull origin master'
