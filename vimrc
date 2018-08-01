if 0 | finish | endif
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf8

runtime vim-unbundle/plugin/unbundle.vim

" settings(set *** etc.etc...) {{{
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif
if has("autocmd")
	" カーソル位置を記憶する
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\   exe "normal g`\"" |
				\ endif
endif
set autoindent  " 自動インデント
set backup  " バックアップを有効にする
set backupdir=$HOME/.vimbackup  " バックアップ用ディレクトリ
set directory=$HOME/.vimswap
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
    set undodir=$HOME/.vimundo  " アンドゥ用ディレクトリ
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
    set undofile "全てのファイルでundo履歴を残す [http://vim-users.jp/2010/07/hack162/]()
endif
"set list  " 不可視文字の表示
set scrolloff=4  " スクロール時の余白
"set textwidth=0         " 自動的に改行が入るのを無効化
"set colorcolumn=80      " その代わり80文字目にラインを入れる
set ignorecase
set smartcase
set showcmd  " コマンドを表示
set laststatus=2 " ステータスラインを表示
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%{fugitive#statusline()}\ %l,%c%V%8P " ステータスラインにファイル名・文字コード・改行形式を表示
set ts=4  " タブ幅
set sw=4  " シフト幅
set smarttab   "use shiftwidth when inserts <tab>
set expandtab  " タブをスペースに展開
set incsearch  "incremental search
set hlsearch
set wrap  "長い行を折り返し
if has('linebreak')
  set breakindent
  set breakindentopt=shift:2,sbr
  set showbreak=>
endif
set display=lastline   "as much as possible of the last linein a window will be displayed
syntax enable  " 構文配色を有効にする
set showtabline=2 "常にタブを表示
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set infercase           " 補完時に大文字小文字を区別しない
set hidden
set vb t_vb= "disable visualbell
set virtualedit+=block "矩形選択で自由に移動
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus,autoselect 
  else
    set clipboard+=unnamed "無名レジスタだけでなく、*レジスタにもヤンク
  endif
endif
set wildmode=longest:full,full
set wildmenu
set showmatch
set matchtime=1
set matchpairs=(:),{:},[:],<:>
set backspace=indent,eol,start "help i_backspacing
set history=10000
" folding {{{
set foldenable
set foldmethod=marker
autocmd BufNewFile,BufRead *.l setlocal commentstring=\;%s
autocmd BufNewFile,BufRead *.py setlocal commentstring=\ \#%s
autocmd BufNewFile,BufRead *.rb setlocal commentstring=\ \#%s
autocmd BufNewFile,BufRead *.mkd setlocal commentstring=\ <!--\ %s\ -->
autocmd BufNewFile,BufRead *.md setlocal commentstring=\ <!--\ %s\ -->
autocmd BufNewFile,BufRead *.launch setlocal commentstring=\ <!--\ %s\ -->
"}}}
" set filetypes {{{
au BufNewFile,BufRead *.thtml set filetype=php
au BufNewFile,BufRead *.ctp set filetype=php
au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.py set filetype=python
au BufNewFile,BufRead *.rb set filetype=ruby
au BufNewFile,BufRead *.launch set filetype=launch syntax=xml
au BufNewFile,BufRead *.page set filetype=markdown
au BufNewFile,BufRead *.mkd set filetype=markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.l set filetype=lisp
au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead *.m set filetype=octave
"}}}
set shellslash
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
  set cryptmethod=blowfish
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
"}}}

" mappings {{{
nnoremap <Space>t :<C-u>tabedit 
nnoremap <Space>e :<C-u>edit 
nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>
nnoremap <silent> <Space>n :<C-u>tabnext<CR>
nnoremap <silent> <Space>p  :<C-u>tabprevious<CR>
"nnoremap <Space>c :<C-u>new<CR>:r! 
nnoremap <Space>d :<C-u>bd<CR>
nnoremap <Space>p :<C-u>pwd<CR>
nnoremap <Leader>y my:0,$!xsel -iob<CR>u`y
nnoremap <Space><Space> i<Space><Esc>la<Space><Esc>
nnoremap <S-tab> za
noremap ; :
noremap : ;

imap <ESC>OA <Up>
imap <ESC>OB <Down>
imap <ESC>OD <Left>
imap <ESC>OC <Right>
imap <silent> <c-b> <Left>
imap <silent> <c-f> <Right>

" tagsジャンプの時に複数ある時は一覧表示                                        
nnoremap <C-]> g<C-]> 

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-X> <C-R>=<SID>GetBufferDirectory()<CR>
function! s:GetBufferDirectory()
  let path = expand('%:p:h')
  return path . (exists('+shellslash') && !&shellslash ? '\' : '/')
endfunction
cabbr w!! w !sudo tee > /dev/null %
"}}}
" fugitive "{{{
if has('autocmd')
    autocmd User fugitive
      \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
      \   nnoremap <buffer> .. :edit %:h<CR> |
      \ endif
    autocmd BufReadPost fugitive://* set bufhidden=delete
endif
"}}}
" unite {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_source_grep_command = 'ag --nogroup --nobreak --noheading --nocolor -g "" %s '
call unite#custom#profile('default', 'context', {
          \   'start_insert': 1,
          \   'winheight': 10,
          \   'direction': 'botright',
          \ })
let g:unite_source_file_mru_long_limit = 1000000
let g:unite_source_grep_max_candidates = 1000000
let g:unite_source_find_max_candidates = 1000000
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{
imap <silent> <buffer> <C-c> <Plug>(unite_exit)
nmap <silent> <buffer> <C-c> <Plug>(unite_exit)
imap <buffer><expr> S    unite#mappings#set_current_sorters(
            \ empty(unite#mappings#get_current_sorters()) ?
            \ ['sorter_reverse'] : [])
endfunction "}}}

nnoremap [Unite] <Nop>
nmap     <C-s>   [Unite]
nnoremap <silent> [Unite]<C-s> :<C-u>Unite file<CR>
nnoremap <silent> [Unite]<C-p> :<C-u>Unite file_rec/async<CR>
nnoremap <silent> [Unite]<C-m> :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]<C-d> :<C-u>Unite directory<CR>
nnoremap <silent> [Unite]<C-g> :<C-u>Unite line<CR>
nnoremap <silent> [Unite]<C-h> :<C-u>Unite history/command<CR>
nnoremap <silent> [Unite]/     :<C-u>Unite history/search<CR>
nnoremap <silent> [Unite]<C-t> :<C-u>Unite locate<CR>
command! Outline execute ":Unite outline -no-start-insert -vertical -no-quit -no-auto-quit -winwidth=50<CR>"
" }}}
" quickrun {{{
let g:quickrun_config = {}
if has('job')
  let g:quickrun_config = { 
           \ "_" : { 
           \ "outputter/buffer/split" : ":botright", 
           \ "outputter/buffer/close_on_empty" : 1 ,
           \ "runner" : "job",
           \ "runner/job/interval" : 60
           \ }, 
           \}
elseif g:loaded_vimproc
  let g:quickrun_config = { 
           \ "_" : { 
           \ "outputter/buffer/split" : ":botright", 
           \ "outputter/buffer/close_on_empty" : 1 ,
           \ "runner" : "vimproc",
           \ "runner/vimproc/updatetime" : 60
           \ }, 
           \}
endif

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
"neocomplete {{{
function! s:has_neocomplete_required()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction
if s:has_neocomplete_required()
  " neocomplete settings
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif
"}}}
" neosnippet {{{
" snippetの配置場所
let g:neosnippet#snippets_directory='~/.vim/snippets'
"set completeopt-=preview
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

"<TAB>でスニペット補完 
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>" 
"スニペットで単語が選択されている場合でも <Tab> で次のプレースホルダへ移動する 
vmap <expr><TAB> neosnippet#expandable() ?  \<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}
" python {{{
" jedi-vim
if s:has_neocomplete_required() && !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
  autocmd FileType python setlocal omnifunc=jedi#completions
  let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
endif

" jediにvimの設定を任せると'completeopt+=preview'するので
" 自動設定機能をOFFにし手動で設定を行う
let g:jedi#auto_vim_configuration = 0
" 補完の最初の項目が選択された状態だと使いにくいためオフにする
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
" quickrunと被るため大文字に変更
let g:jedi#rename_command = '<Leader>R'
" 自動定義表示させない
"let g:jedi#show_function_definition = "0"
let g:jedi#show_call_signatures = "0"
"autocmd FileType python let b:did_ftplugin = 1
let python_highlight_all = 1
"}}}
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
  return join(split(a:output, "\n")[20 :], "\n")
endfunction
function! g:ref_source_webdict_sites.weblio.filter(output)
  return join(split(a:output, "\n")[0 :], "\n")
endfunction
function! g:ref_source_webdict_sites.thesaurus.filter(output)
  return join(split(a:output, "\n")[41 :], "\n")
endfunction
function! g:ref_source_webdict_sites.antonym.filter(output)
  return join(split(a:output, "\n")[49 :], "\n")
endfunction
"}}}
" ag {{{
let g:ag_prg="ag --vimgrep --smart-case --ignore='*__pycache__*' --ignore='*.pyc' --ignore='tags' "
let g:ag_highlight=1
noremap <Space>ag :<C-u>Ag<Space>
noremap <Space>af :<C-u>AgFile<Space>
"}}}
" airline{{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_extensions = ['branch', 'ctrlp', 'quickfix', 'tabline', 'unite', 'wordcount', 'gutentags', 'cwd']
"'hunks', 'nrrwrgn', 'syntastic', 'tagbar', 'undotree', 'windowswap', 'whitespace'
let g:airline_theme='ravenpower' "'minimalist' 'serene' 'simple' 'wombat''papercolor'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = 'LF'
"let g:airline_symbols.linenr = 'NL'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat='\c\vgundo|undotree|vimfiler|tagbar|nerd_tree|tweetvim_say'
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
" gutentags {{{
let g:gutentags_cache_dir=expand('~') . '/.gutentags'
if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, "p")
endif
" }}}
set background=dark
"colorscheme Tomorrow-Night-Blue
"colorscheme harlequin
"let g:solarized_termcolors=256
"let g:solarized_termtrans =   1
"let g:solarized_degrade   =   1
"let g:solarized_contrast  =   "high" 
"let g:solarized_visibility=   "high"
"colorscheme solarized
colorscheme PaperColor
" 配色設定"{{{
set t_Co=256
" 90 ... purple which we can use only when 256-colors is enabled
hi Pmenu        ctermfg=White   ctermbg=90  cterm=NONE
hi PmenuSel     ctermfg=90   ctermbg=White  cterm=NONE
hi PmenuSbar    ctermfg=90   ctermbg=White  cterm=NONE
hi PmenuThumb   ctermfg=White   ctermbg=90  cterm=NONE

highlight LineNr ctermfg=40
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

" ctrlp {{{
nnoremap <silent><C-l><C-p> :<C-u>CtrlP<CR>
nnoremap <silent><C-l><C-s> :execute ':<C-u>CtrlP <C-r>=expand('%:h:p')<CR><CR>'
nnoremap <silent><C-l><C-b> :<C-u>CtrlPBuffer<CR>
nnoremap <silent><C-l><C-m> :<C-u>CtrlPMRU<CR>
nnoremap <silent><C-l><C-d> :<C-u>CtrlPDir<CR>
nnoremap <silent><C-l><C-k> :execute ':<C-u>CtrlPDir <C-r>=expand('%:h:p')<CR><CR>'
"nnoremap <silent><C-l><C-g> :<C-u>CtrlPLine<CR>
nnoremap <silent><C-l><C-c> :<C-u>CtrlPQuickfix<CR>
nnoremap <silent><C-l><C-r> :<C-u>CtrlPRegister<CR>
"nnoremap <silent><C-l><C-f> :<C-u>CtrlPF<CR>
"nnoremap <silent><C-l><C-z> :<C-u>CtrlPZ<CR>
nnoremap <silent><C-l>rc    :<C-u>CtrlPRoscd<CR>
nnoremap <silent><C-l>re    :<C-u>CtrlPRosed<CR>
nnoremap <silent><C-l>f     :<C-u>CtrlPFunky<Cr>
nnoremap <silent><C-l><C-h> :<C-u>CtrlPCmdHistory<CR>
nnoremap <silent><C-l>/     :<C-u>CtrlPSearchHistory<CR>
nnoremap <silent><C-l>l     :<C-u>CtrlPLocate<CR>
nnoremap <silent><C-l><C-t> :<C-u>CtrlPSmartTabs<CR>
nnoremap <silent><C-l><C-g> :<C-u>CtrlPGrep<CR>
"nnoremap <silent><C-l><C-f> :<C-u>CtrlPFiler<CR>
"let g:ctrlp_filer_menu = {
"      \ "execute": 'ctrlp#filer#op#execute',
"      \ "open":    'ctrlp#filer#op#open',
"      \ "delete":  'ctrlp#filer#op#delete',
"      \ "rename":  'ctrlp#filer#op#rename',
"      \ "create":  'ctrlp#filer#op#create'
"      \}
"let g:ctrlp_filer_disable_lcd = 1
let g:ctrlp_funky_sort_reverse=1

let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_map = '<c-l><c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_use_caching = 1
if executable('files') && executable('grep')
  let g:ctrlp_user_command = 'files -A %s | grep -v -e ".exe$" -e ".so$" -e ".dll$" -e ".db$" -e ".o$" -e ".a$" -e ".pyc$" -e ".pyo$" -e ".pdf$" -e ".dvi$" -e ".zip$" -e ".rar$" -e ".tgz$" -e ".gz$" -e ".tar$" -e ".png$" -e ".jpg$" -e ".JPG$" -e ".gif$" -e ".mpg$" -e ".mp4$" -e ".mp3$" -e ".bag$"'
endif
let g:ctrlp_max_files = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_max = 1000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|neocon|cache|Skype|fontconfig|vimbackup|wine|thumbnail|mozilla|local|thunderbird|vimundo|neocomplcache|rvm|cache|vimswap|rbenv)$',
            \ 'file': '\v(\.(exe|so|dll|db|o|a|pyc|pyo|pdf|dvi|zip|rar|tgz|gz|tar|png|jpg|JPG|gif|mpg|mp4|mp3|bag|sw[a-z])|tags)$',
            \ }
            "\ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.neocon$\|\.cache$\|\.Skype$\|\.fontconfig$\|\.vimbackup$\|\.wine$\|\.thumbnails$\|\.mozilla$\|\.local$\|\.thunderbird$\|\.vimundo$\|\.neocomplcache$\|\.rvm$\|\.cache$\|\.vimswap$|\.rbenv$',
            "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.db$\|\.o$\|\.a$\|\.pyc$\|\.pyo$\|\.pdf$\|\.dvi$\|\.zip$\|\.rar$\|\.tgz$\|\.gz$\|\.tar$\|\.png$\|\.jpg$\|\.JPG$\|\.gif$\|\.mpg$\|\.mp4$\|\.mp3$\|\.bag$\|\.sw[a-z]$',
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|vimfiler\|unite\|vimshell'
let g:ctrlp_lazy_update = 0
let g:ctrlp_key_loop = 0
let g:ctrlp_tjump_only_silent = 1
if exists(':CtrlPtjump')
    let g:ctrlp_tjump_only_silent=1
    nnoremap <c-]> :CtrlPtjump<cr>
    vnoremap <c-]> :CtrlPtjumpVisual<cr>
endif
"}}}
"openbrowser"{{{
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
function! s:enable_lemonade() abort
    "let g:openbrowser_browser_commands_default = get(g:, 'openbrowser_browser_commands', '')
    if executable('lemonade')
        let g:openbrowser_browser_commands = [
                    \   {'name': 'lemonade',
                    \    'args': ['{browser}', 'open', '{uri}'],
                    \    'background': 1}
                    \]
        echomsg "lemonade client enabled"
    else
        echomsg "lemonade is not on the path?"
    endif
endfunction
command! EnableLemonade call s:enable_lemonade()
nmap <space>ob <Plug>(openbrowser-open)
vmap <space>ob <Plug>(openbrowser-open)
nmap <space>ow <Plug>(openbrowser-search)
nmap <space>os <Plug>(openbrowser-smart-search)
vmap <space>os <Plug>(openbrowser-smart-search)
"}}}
" dirvish {{{
let g:dirvish_hijack_netrw=1
nnoremap <silent> <space>E :<C-u>Dirvish %<CR>
" }}}
" tweetvim {{{
let g:tweetvim_display_separator = 0
let g:tweetvim_async_post = 1
let g:tweetvim_display_icon = 0
let g:tweetvim_display_source = 1
let g:tweetvim_display_time   = 1
let g:tweetvim_include_rts    = 1
let g:tweetvim_expand_t_co = 1
let g:tweetvim_silent_say = 1
let g:tweetvim_default_account = "ompugao"
nmap <silent> g<ESC> <Plug>(tweetvim_notify)
"let g:tweetvim_display_username = 1
nmap <silent> g<ESC> <Plug>(tweetvim_notify)
" }}}
" vim-easy-align{{{
vnoremap <silent> <Enter> :LiveEasyAlign<cr>
" }}}
" operator-replace {{{
map R <Plug>(operator-replace)
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
let g:ale_enabled=0
filetype plugin indent on
