if 0 | finish | endif
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf8

" gutentags {{{
let g:gutentags_cache_dir=expand('~') . '/.gutentags'
if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, "p")
endif
" }}}

" Strange character since last update (>4;2m) in vim - Stack Overflow https://stackoverflow.com/questions/62148994/strange-character-since-last-update-42m-in-vim
" https://stackoverflow.com/questions/62148994/strange-character-since-last-update-42m-in-vim
let &t_TI = ""
let &t_TE = ""

" plugins {{{
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'Shougo/vimproc', { 'do': 'make' }
Plug 'junegunn/vim-easy-align'
Plug 'thinca/vim-quickrun'
Plug 'mattn/quickrunex-vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'
Plug 'thinca/vim-textobj-between'
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'hdima/python-syntax', {'for': 'python'}
Plug 'thinca/vim-ref'
Plug 'haya14busa/vim-asterisk'
Plug 'bling/vim-airline'
Plug 'ompugao/vim-airline-cwd'
Plug 'ompugao/markshift', {'for': 'markshift'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ompugao/ctrlp-history'
Plug 'ompugao/ctrlp-locate'
Plug 'img-paste-devs/img-paste.vim'
" Plug 'DavidEGx/ctrlp-smarttabs'
" Plug 'ompugao/uncrustify-vim'
" Plug 'haya14busa/vim-migemo'
Plug 'tyru/eskk.vim'
"Plug 'vim-denops/denops.vim'
"Plug 'vim-skk/skkeleton'
Plug 'kshenoy/vim-signature'
Plug 'Shougo/vinarise', {'on': 'Vinarize'}
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/webapi-vim'
Plug 'tyru/open-browser.vim'
" Plug 'previm/previm'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'airblade/vim-gitgutter'
Plug 'mopp/autodirmake.vim'
Plug 'mattn/emmet-vim'
" Plug 'sunaku/vim-unbundle'
Plug 'ivalkeen/vim-ctrlp-tjump'
" Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline-themes'
Plug 'ompugao/ctrlp-tweetvim'
" Plug 'jvirtanen/vim-octave', {'for': 'octave'}
Plug 'cohama/agit.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'justinmk/vim-dirvish'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'skywind3000/asyncrun.vim'
Plug 'cocopon/iceberg.vim'
Plug 'racer-rust/vim-racer', {'for': 'rust'}
" Plug 'ompugao/harlequin'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rhysd/vim-clang-format'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'thomasfaingnaert/vim-lsp-neosnippet'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'ompugao/quickdict.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'Yggdroot/indentLine'
Plug 'preservim/tagbar'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/fern.vim', {'branch': 'main'}
Plug 'lambdalisue/fern-git-status.vim'
" Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'ompugao/cpsm', {'branch': 'feature/remove_boost_dependency', 'do': './install.sh' }
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()
"}}}

" settings(set *** etc.etc...) {{{
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif
augroup mysettings
    autocmd!
    " カーソル位置を記憶する
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup END
set autoindent  " 自動インデント
set backup  " バックアップを有効にする
if has('nvim')
  set backupdir=$HOME/.nvimbackup  " バックアップ用ディレクトリ
  set directory=$HOME/.nvimswap
else
  set backupdir=$HOME/.vimbackup  " バックアップ用ディレクトリ
  set directory=$HOME/.vimswap
endif
set diffopt+=vertical
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
" open file read-only when it finds a swap file
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END
if has('persistent_undo')
    if has('nvim')
        set undodir=$HOME/.nvimundo  " アンドゥ用ディレクトリ
    else
        set undodir=$HOME/.vimundo  " アンドゥ用ディレクトリ
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
    set undofile "全てのファイルでundo履歴を残す [http://vim-users.jp/2010/07/hack162/]()
endif
set list  " 不可視文字の表示
set listchars=tab:>-,trail:_,nbsp:%
set scrolloff=4  " スクロール時の余白
set ignorecase
set smartcase
"set titlestring=%t  " see :help statusline  or :help titlestring
set showcmd  " コマンドを表示 
set laststatus=2 " ステータスラインを表示
set ts=4  " タブ幅
set sw=4  " シフト幅
set smarttab   "use shiftwidth when inserts <tab>
set noexpandtab  " タブをスペースに展開
au FileType h,cpp,cuda,vim set expandtab
set incsearch  "incremental search
set hlsearch
set wrap  "長い行を折り返し
if has('linebreak')
  set breakindent
  "set breakindentopt=shift:2,sbr
  set breakindentopt=min:50,shift:4,sbr
  "set showbreak=>
  set showbreak=↪
endif
set display=lastline   "as much as possible of the last linein a window will be displayed
syntax enable  " 構文配色を有効にする
set showtabline=2 "常にタブを表示
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set infercase           " 補完時に大文字小文字を区別しない
set hidden
set vb t_vb= "disable visualbell
set virtualedit+=block "矩形選択で自由に移動
set nrformats+=unsigned "increment ignoring `-'
if has('nvim')
  set clipboard=unnamedplus
else
  if has('clipboard')
    if has('unnamedplus')
      set clipboard=unnamedplus,autoselect 
    else
      set clipboard+=unnamed "無名レジスタだけでなく、*レジスタにもヤンク
    endif
  endif
endif
set wildmode=longest:full,full
set wildmenu
if has('patch-8.2.4325')
  set wildoptions=pum
endif
set showmatch
set matchtime=1
set matchpairs=(:),{:},[:],<:>
set backspace=indent,eol,start "help i_backspacing
set history=10000
set foldenable
set foldmethod=marker
augroup myfiletypes
    autocmd!
    autocmd BufNewFile,BufRead *.l setlocal commentstring=\;%s
    autocmd BufNewFile,BufRead *.py setlocal commentstring=\ \#%s
    autocmd BufNewFile,BufRead *.rb setlocal commentstring=\ \#%s
    autocmd BufNewFile,BufRead *.md setlocal commentstring=\ <!--\ %s\ -->
    autocmd BufNewFile,BufRead *.launch setlocal commentstring=\ <!--\ %s\ -->
    au BufNewFile,BufRead *.launch set filetype=launch syntax=xml
    au BufNewFile,BufRead *.l set filetype=lisp
    "au BufNewFile,BufRead *.m set filetype=octave
augroup END
set shellslash
set isfname&
  \ isfname+=@-@
  \ isfname-==
set grepprg=grep\ -nH\ $*
let g:tex_conceal = ""
augroup vimrc-auto-cursorline "http://d.hatena.ne.jp/thinca/20090530/1243615055 {{{ 
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END "}}}
if exists("&cryptmethod")
  set cryptmethod=blowfish2
endif
let g:markdown_fenced_languages = [
\  'css',
\  'erb=eruby',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'sass',
\  'xml',
\]
if has('patch-7.4.146') 
  command! Oldfiles execute ":new +setl\\ buftype=nofile | 0put =v:oldfiles | nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>"
endif
" Copy-Paste in xfce4-terminal adds 0~ and 1~
" https://unix.stackexchange.com/questions/196098/copy-paste-in-xfce4-terminal-adds-0-and-1
set t_BE=
" https://stackoverflow.com/a/30552423
augroup highlight_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo
" https://zenn.dev/hokorobi/articles/98f79339d7d114
augroup syntax_off_for_big_file
	autocmd!
	autocmd BufEnter * if getfsize(@%) > 1000 * 1000 | setlocal syntax=OFF | call interrupt() | endif
augroup END
"}}}

" mappings {{{
nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>
nnoremap <Space>d :<C-u>bd<CR>
nnoremap <Space><Space> i<Space><Esc>la<Space><Esc>
"nnoremap <S-tab> za
noremap ; :
noremap : ;

imap <silent> <c-b> <Left>
imap <silent> <c-f> <Right>
"tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-X> <C-R>=<SID>GetBufferDirectory()<CR>
function! s:GetBufferDirectory()
  let path = expand('%:p:h')
  return path . (exists('+shellslash') && !&shellslash ? '\' : '/')
endfunction
cnoremap <C-T> <C-R>=strftime('%Y_%m_%d')<CR>
cabbr w!! w !sudo tee > /dev/null %
" yank to clipboard via xsel
nnoremap <Leader>y my:0,$!xsel -iob<CR>u`y
" "switched to oscyank plugin
" if executable('kitty')
"   nnoremap <leader>Y :call system('kitty +kitten clipboard', @0)<CR>
"   vnoremap <leader>Y :call system('kitty +kitten clipboard', @0)<CR>
" else
"   " clipper https://github.com/wincent/clipper
"   nnoremap <leader>Y :call system('nc -N localhost 8377', @0)<CR>
"   vnoremap <leader>Y :call system('nc -N localhost 8377', @0)<CR>
" endif
"}}}
" fugitive "{{{
augroup myfugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
"}}}
" quickrun {{{
let g:quickrun_config = { 
        \ "_" : { 
        \ "outputter/buffer/split" : ":botright", 
        \ "outputter/buffer/close_on_empty" : 1 ,
        \ "runner" : "job",
        \ "runner/job/interval" : 60
        \ }, 
        \}
let g:quickrun_config.markdown = {
      \ 'type': 'markdown/pandoc',
      \ 'outputter': 'browser',
      \ 'cmdopt': '--mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML" -c $HOME/dotfiles/vim/misc/githublike.css -s'
      \ }
let g:quickrun_config.coffee = {
            \ 'command' : 'coffee',
            \ 'exec' : ['%c -cbp %s']
            \ }
let g:quickrun_config['cpp/clang++11'] = {
            \ 'command': 'clang++',
            \ 'cmdopt': '--std=c++11 --stdlib=libc++',
            \ 'type': 'cpp/clang++'
            \ }
let g:quickrun_config['cpp/g++11'] = {
      \   'command': 'g++',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'tempfile': '%{tempname()}.cpp',
      \   'hook/sweep/files': '%S:p:r',
      \   'cmdopt':  '-std=c++11 '
      \ }
let g:quickrun_config['cpp/g++14'] = {
      \   'command': 'g++',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'tempfile': '%{tempname()}.cpp',
      \   'hook/sweep/files': '%S:p:r',
      \   'cmdopt':  '-std=c++14 '
      \ }
let g:quickrun_config.octave = {
            \ 'command': 'octave',
            \ } 
" <C-c> で実行を強制終了させる
" quickrun.vim が実行していない場合には <C-c> を呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"}}}
"asynccomplete {{{
" if executable('mdls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'mdls',
"         \ 'cmd': ['mdls', '-v', '--log-file', './mdls.log'],
"         \ 'whitelist': ['md', 'markdown'],
"         \ })
"     autocmd FileType markdown setlocal omnifunc=lsp#omni#complete
" endif

function! s:setup_markshift() abort
	let s:msls_client_id = lsp#register_server({
				\ 'name': 'msls',
				\ 'cmd': ['python3', '-m', 'markshift.langserver.server', '--never_steal_focus', '--always_on_top', '--logfile=msls.log'],
				\ 'allowlist': ['markshift'],
				\ })
				"\ 'cmd': ['msls'],
				"\ 'cmd': ['msls', '--never_steal_focus', '--always_on_top', '--logfile=msls.log'],
endfunction

augroup vim_lsp_settings_markshift-language-server
  au!
  au User lsp_setup call s:setup_markshift()
  au FileType markshift setlocal omnifunc=lsp#omni#complete
augroup END

set updatetime=300
let g:lsp_work_done_progress_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
" function! s:on_lsp_buffer_enabled() abort
"   setlocal omnifunc=lsp#complete
"   setlocal signcolumn=yes
"   setlocal completeopt-=preview
"   "nmap <buffer> gd <plug>(lsp-definition)
"   "nmap <buffer> <f2> <plug>(lsp-rename)
"   inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
" endfunction
" augroup lsp_install
"   au!
"   autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

" let g:lsp_settings = {
" \  'clangd': {
" \    'cmd': ['clangd', '-compile_args_from=filesystem'],
" \  }
" \}
" :LspSettingsLocalEdit and put the following text (change the build directory part for your 
" every project)
" {
"     'clangd': {
"         'initialization_options': {'compilationDatabasePath': 'build'}
"     }
" }

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['markshift'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'priority': 15,
    \ 'min_chars': 2,
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'min_chars': 0,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
    \ 'name': 'neosnippet',
    \ 'whitelist': ['*'],
    \ 'blocklist': ['markshift'],
    \ 'priority': 5,
    \ 'min_chars': 1,
    \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
    \ }))

set completeopt=menuone,noinsert,noselect
set pumheight=10 "set the height of completion menu

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
"let g:asyncomplete_auto_popup = 0
let s:auto_popup_filetypes = ['markshift']
au InsertEnter * exe 'let g:asyncomplete_auto_popup = '.(index(s:auto_popup_filetypes, &ft) >= 0 ? '1' : '0')
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 10
let g:asyncomplete_min_chars = 0
let g:asyncomplete_matchfuzzy = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_experimental_workspace_folders = 1
let g:lsp_experimental_show_document = 1
let g:lsp_signs_enabled = 0         " enable signs
let g:lsp_signs_error = {'text': 'XX'}
let g:lsp_signs_warning = {'text': '!!'}"
let g:lsp_auto_enable = 1
"}}}
" neosnippet {{{
let g:neosnippet#snippets_directory='~/.vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=c
  let g:indentLine_fileTypeExclude=['dirvish']
  let g:indentLine_fileTypeExclude=['dirvish', 'gina-status']
  let g:indentLine_concealcursor='c'
endif
" }}}
" refe {{{
let g:ref_use_vimproc=1
let g:ref_refe_version=2
nnoremap <Space>rr  :<C-u>Ref refe<Space>
nnoremap <Space>rm  :<C-u>Ref man<Space>
nnoremap <Space>rpy :<C-u>Ref pydoc<Space>
nnoremap <Space>rw  :<C-u>Ref webdict<Space>
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\   'alc': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\   },
\   'weblio': {
\     'url': 'http://www.weblio.jp/content/%s',
\   },
\   'thesaurus': {
\     'url': 'http://thesaurus.weblio.jp/content/%s'
\   },
\   'antonym': {
\     'url': 'http://thesaurus.weblio.jp/antonym/content/%s'
\   }
\ }
 
"default site
let g:ref_source_webdict_sites.default = 'alc'
"filters
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
function! g:ref_source_webdict_sites.alc.filter(output)
  return substitute(join(split(a:output, "\n")[96 :], "\n"), '｛.\{-}｝', '', 'g')
endfunction
function! g:ref_source_webdict_sites.weblio.filter(output)
  return substitute(join(split(a:output, "\n")[0 :], "\n"), '｛.\{-}｝', '', 'g')
endfunction
function! g:ref_source_webdict_sites.thesaurus.filter(output)
  return join(split(a:output, "\n")[41 :], "\n")
endfunction
function! g:ref_source_webdict_sites.antonym.filter(output)
  return join(split(a:output, "\n")[49 :], "\n")
endfunction
"}}}
" quickdict.vim {{{
nnoremap <Space>rq :<C-u>QuickDictEcho <C-r><C-w><CR>
nnoremap <Space>ra :<C-u>QuickDictAppend <C-r><C-w><CR>
nnoremap <Space>rA :<C-u>QuickDictInsertLast <C-r><C-w><CR>
" }}}
" vim-grepper {{{
"let g:ag_prg="ag --vimgrep --smart-case --ignore='*__pycache__*' --ignore='*.pyc' --ignore='tags' "
"let g:ag_highlight=1
let g:grepper = {}
let g:grepper.stop = 10000
let g:grepper.rg = {'grepprg': 'rg -H --no-heading --vimgrep --smart-case -g "!tags"'}
"noremap <Space>ga :<C-u>Grepper -tool ag<CR>
noremap <Space>gg :<C-u>Grepper -tool git<CR>
noremap <Space>gi :<C-u>Grepper -tool rg<CR>
noremap <Space>g* :<C-u>Grepper -tool rg -cword -noprompt<CR>
"}}}
" airline{{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_extensions = ['branch', 'ctrlp', 'quickfix', 'tabline', 'wordcount', 'gutentags', 'cwd', 'lsp']
let g:airline_theme='ayu_mirage' "'minimalist' 'serene' 'simple' 'wombat''papercolor'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = 'LF'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat='\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#disable_rtp_load = 0
let g:airline#extensions#cwd#enabled = 1
"let g:airline#extensions#alpaca_tags#enabled = 1
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 80,
      \ 'y': 88,
      \ 'z': 60,
      \ }
let g:airline#extensions#whitespace#enabled = 1
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'v',
            \ 'V'  : 'V',
            \ '' : '^V',
            \ 's'  : 's',
            \ 'S'  : 'S',
            \ '' : '^',
            \ }
" }}}
" 配色設定"{{{
set background=dark
"colorscheme Tomorrow-Night-Blue
"colorscheme harlequin
colorscheme PaperColor
set t_Co=256
" 90 ... purple which we can use only when 256-colors is enabled
" hi Pmenu        ctermfg=White   ctermbg=90  cterm=NONE
" hi PmenuSel     ctermfg=90   ctermbg=White  cterm=NONE
" hi PmenuSbar    ctermfg=90   ctermbg=White  cterm=NONE
" hi PmenuThumb   ctermfg=White   ctermbg=90  cterm=NONE

" highlight LineNr ctermfg=40
" highlight Visual term=reverse ctermbg=90 guibg=LightGrey
" 全角スペースの表示
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
highlight MatchParen term=standout ctermbg=LightGrey ctermfg=lightcyan guibg=LightGrey guifg=lightcyan
"match ZenkakuSpace /　/
" make background transparent
highlight Normal ctermbg=none
let g:netrw_liststyle = 3 "netrw(Explorer)を常にツリー表示する
let lisp_rainbow = 1 "lispをcolorfulに
"}}}

" fzf {{{
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']
let g:fzf_layout = { 'down': '~40%' }
let $FZF_DEFAULT_OPTS .= ' --info=inline --keep-right '
let g:fzf_files_options='--info=inline --preview "basename {}" --preview-window "down:1:noborder"'
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)
function! s:fzfhistory(...)
  return fzf#run(fzf#wrap('history-files', {
  \ 'source':  fzf#vim#_recent_files(),
  \ 'options': ['-m', '--header-lines', !empty(expand('%')), '--prompt', 'Hist> ',
  \ '--preview', "basename {}", '--preview-window', "down:1:noborder"]
  \}))
endfunction
command! -bang -nargs=? FileHistory call s:fzfhistory(<q-args>, <bang>0)
augroup fzfconf
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"nnoremap <silent><C-l><C-p> :<C-u>Files<CR>
"nnoremap <silent><C-l><C-s> :execute ':<C-u>Files <C-r>=expand('%:h:p')<CR><CR>'
"nnoremap <silent><C-l><C-b> :<C-u>Buffers<CR>
"nnoremap <silent><C-l><C-m> :<C-u>FileHistory<CR>
"nnoremap <silent><C-l><C-h> :<C-u>History:<CR>
"nnoremap <silent><C-l>/     :<C-u>History/<CR>
"nnoremap <C-l>l     :<C-u>Locate 
" }}}
" ctrlp {{{
let g:ctrlp_map = '<c-l><c-p>'
nnoremap <silent><C-l><C-p> :<C-u>CtrlP<CR>
nnoremap <silent><C-l><C-s> :execute ':<C-u>CtrlP <C-r>=expand('%:h:p')<CR><CR>'
nnoremap <silent><C-l><C-b> :<C-u>CtrlPBuffer<CR>
nnoremap <silent><C-l><C-r> :<C-u>CtrlPMRU<CR>
nnoremap <silent><C-l><C-m> :<C-u>CtrlPMRU<CR>
nnoremap <silent><C-l><C-d> :<C-u>CtrlPDir<CR>
nnoremap <silent><C-l><C-k> :execute ':<C-u>CtrlPDir <C-r>=expand('%:h:p')<CR><CR>'
nnoremap <silent><C-l><C-c> :<C-u>CtrlPQuickfix<CR>
nnoremap <silent><C-l>f     :<C-u>CtrlPFunky<Cr>
nnoremap <silent><C-l><C-h> :<C-u>CtrlPCmdHistory<CR>
nnoremap <silent><C-l>/     :<C-u>CtrlPSearchHistory<CR>
nnoremap <silent><C-l>l     :<C-u>CtrlPLocate<CR>
nnoremap <silent><C-l><C-t> :<C-u>CtrlPSmartTabs<CR>
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_use_caching = 1
if executable('rg')
  let g:ctrlp_user_command = 'rg --hidden --files %s | rg -v -e "\.git/" -e "\.exe$" -e "\.so$" -e "\.dll$" -e "\.db$" -e "\.o$" -e "\.a$" -e "\.pyc$" -e "\.pyo$" -e "\.pdf$" -e "\.dvi$" -e "\.zip$" -e "\.rar$" -e "\.tgz$" -e "\.gz$" -e "\.tar$" -e "\.png$" -e "\.jpg$" -e "\.JPG$" -e "\.gif$" -e "\.mpg$" -e "\.mp4$" -e "\.mp3$" -e "\.bag$"'
endif
let g:ctrlp_max_files = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_max = 1000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|neocon|cache|Skype|fontconfig|vimbackup|nvimbackup|wine|thumbnail|mozilla|local|thunderbird|vimundo|nvimundo|neocomplcache|rvm|cache|vimswap|nvimswap|rbenv)$',
            \ 'file': '\v(\.(exe|so|dll|db|o|a|pyc|pyo|pdf|dvi|zip|rar|tgz|gz|tar|png|jpg|JPG|gif|mpg|mp4|mp3|bag|sw[a-z])|tags)$',
            \ }
            "\ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.neocon$\|\.cache$\|\.Skype$\|\.fontconfig$\|\.vimbackup$\|\.wine$\|\.thumbnails$\|\.mozilla$\|\.local$\|\.thunderbird$\|\.vimundo$\|\.neocomplcache$\|\.rvm$\|\.cache$\|\.vimswap$|\.rbenv$',
            "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.db$\|\.o$\|\.a$\|\.pyc$\|\.pyo$\|\.pdf$\|\.dvi$\|\.zip$\|\.rar$\|\.tgz$\|\.gz$\|\.tar$\|\.png$\|\.jpg$\|\.JPG$\|\.gif$\|\.mpg$\|\.mp4$\|\.mp3$\|\.bag$\|\.sw[a-z]$',
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|vimfiler\|unite\|vimshell'
let g:ctrlp_lazy_update = 0
let g:ctrlp_key_loop = 0
let g:ctrlp_funky_sort_reverse=1
let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_tjump_only_silent = 1
" if has('python3')
"   let g:fruzzy#usenative = 1
"   let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
" elseif exists('*matchfuzzy')
if exists('*matchfuzzy')
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif
if has('python3')
  let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
endif
let g:ctrlp_tjump_shortener = ['/home/[^/]*/', '~/']
"if exists(':CtrlPtjump')
"  let g:ctrlp_tjump_only_silent=1
"  nnoremap <c-]> :CtrlPtjump<cr>
"  vnoremap <c-]> :CtrlPtjumpVisual<cr>
"endif
"}}}
"openbrowser"{{{
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap <space>ob <Plug>(openbrowser-open)
vmap <space>ob <Plug>(openbrowser-open)
nmap <space>ow <Plug>(openbrowser-search)
nmap <space>os <Plug>(openbrowser-smart-search)
vmap <space>os <Plug>(openbrowser-smart-search)
"}}}
" dirvish {{{
let g:dirvish_hijack_netrw=1
nnoremap <silent> <space>E :<C-u>Dirvish %<CR>
function! s:setup_dirvish()
  " disable default /
  nunmap <silent> <buffer> /
  nunmap <silent> <buffer> ?
  setlocal conceallevel=2 concealcursor=nvc
endfunction
augroup MyDirVish
  au!
  autocmd FileType dirvish call s:setup_dirvish()
augroup END
" }}}
" vim-easy-align{{{
vnoremap <silent> <Enter> :LiveEasyAlign<cr>
" }}}
" operator-replace {{{
nnoremap <silent> RR R
nnoremap <silent> R <Plug>(operator-replace)
xnoremap <silent> R <Plug>(operator-replace)
"map R <Plug>(operator-replace)
" }}}
" operator-surround {{{
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
"map <silent>sA <Plug>(operator-surround-append-input-in-advance)
"map <silent>sR <Plug>(operator-surround-replace-input-in-advance)
let g:operator#surround#blocks = {
            \ 'markdown' : [
            \       { 'block' : ["```\n", "\n```"], 'motionwise' : ['line'], 'keys' : ['`'] },
            \ ] ,
            \ '-' : [
            \       {'block': ['\<\[a-zA-z0-9_?!]\+\[(\[]', '\[)\]]'], 'motionwise': ['char'], 'keys': ['c']},
            \ ]
            \ }
" }}}
" asterisk {{{
map *  <Plug>(asterisk-*)
map g* <Plug>(asterisk-g*)
map #  <Plug>(asterisk-#)
map g# <Plug>(asterisk-g#)
" }}}
" previm {{{
let g:previm_enable_realtime = 1
"}}}
" vim-markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
"{{{
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
    if mode() ==# 'v'
        return "\<C-v>" . a:next_key
    elseif mode() ==# 'V'
        return "\<C-v>0o$" . a:next_key
    else  " mode() ==# "\<C-v>"
        return a:next_key
    endif
endfunction
"}}}
" tex{{{
function! s:TexReplaceChars()
  echo "replace tex chars"
  try
    exec ":%s/、/, /g"
  catch /^Vim\%((\a\+)\)\=:E486/
  endtry
  try
    exec ":%s/。/. /g"
  catch /^Vim\%((\a\+)\)\=:E486/
  endtry
endfunction
if has('autocmd')
  autocmd BufWrite *.tex call s:TexReplaceChars()
endif
" }}}
" eskk{{{
let g:eskk#show_annotation=1
let g:eskk#large_dictionary = {
            \	'path': "~/.skkjisyo/SKK-JISYO.L",
            \	'sorted': 1,
            \	'encoding': 'euc-jp',
            \}
"}}}
" oscyank {{{
let g:oscyank_silent = v:true
vnoremap <leader>Y :OSCYank<CR>
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
" }}}
let g:ale_enabled=0
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -2,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortBlocksOnASingleLine" : "false",
            \ "AllowShortCaseLabelsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "Empty",
            \ "ColumnLimit" : "120",
            \ "SortIncludes" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "UseTab" : "Never",
            \ "DerivePointerAlignment": "false",
            \ "PointerAlignment": "Left",
            \ "Standard" : "C++11"}

function! s:set_cmake_dictionary() "{{{
  let s:cmake_dict = printf('%s/dict/cmake.txt', expand('<sfile>:p:h'))
  if stridx(&l:dictionary, 'cmake\.txt$') == -1 " only when it doesn't contain
    let &l:dictionary = printf('%s,%s', &l:dictionary, s:cmake_dict)
  endif
endfunction 
autocmd FileType cmake call s:set_cmake_dictionary() "}}}
" toggle terminal {{{
if has('nvim')
  function! s:term_list() abort
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:res = []
    for l:item in l:blist
      if empty(l:item.variables)
        continue
      endif
      if !has_key(l:item.variables, "terminal_job_id")
        continue
      endif
      call add(l:res, l:item.bufnr)
    endfor
    return l:res
  endfunction
  
  function! ToggleTerminal() abort
    let l:terms = s:term_list()
    if empty(l:terms)
      split
      execute "normal! \<c-w>J"
      resize 10
      set wfh
      terminal
      startinsert
    else
      let l:wins = win_findbuf(l:terms[0])
      if empty(l:wins)
        botright 10split
        set wfh
        execute 'buffer' l:terms[0]
        startinsert
      else
        call nvim_win_hide(l:wins[0])
      endif
    endif
  endfunction
else
  function! ToggleTerminal() abort
    let l:terms = term_list()
    if empty(l:terms)
      botright terminal ++rows=10
    else
      let l:wins = win_findbuf(l:terms[0])
      if empty(l:wins)
        botright 10split
        execute 'buffer' l:terms[0]
      else
        call win_execute(l:wins[0], 'hide')
      endif
    endif
  endfunction
endif

inoremap <F2> <cmd>:call ToggleTerminal()<cr>
nnoremap <F2> <cmd>:call ToggleTerminal()<cr>
tnoremap <F2> <cmd>:call ToggleTerminal()<cr>
" }}}
" img-paste {{{
let g:mdip_imgdir = './assets'
"let g:mdip_imgname = 'image'
function! g:MarkshiftPasteImage(relpath)
        execute "normal! i[@img \"" . g:mdip_tmpname[0:0]
        let ipos = getcurpos()
        execute "normal! a" . g:mdip_tmpname[1:] . "\" " . a:relpath . "]"
        call setpos('.', ipos)
        "execute "normal! vt]\<C-g>"
endfunction
augroup markshift-imgpaste
	autocmd!
	autocmd FileType markshift nmap <buffer> <leader>P <cmd>:call mdip#MarkdownClipboardImage()<CR>
	autocmd FileType markshift let g:PasteImageFunction = 'g:MarkshiftPasteImage'
augroup END
" }}}

let g:markshift_enable_default_mappings = 1
filetype plugin indent on
