" Vim-only configuration
" Cleaned up from unified vimrc

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf8

" gutentags {{{
let g:gutentags_cache_dir=expand('~') . '/.gutentags'
let g:gutentags_ctags_extra_args = ['--excmd=number']
if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, "p")
endif
" }}}

" Terminal compatibility
let &t_TI = ""
let &t_TE = ""

" plugins {{{
call plug#begin()
Plug 'github/copilot.vim'
Plug 'rbtnn/vim-ambiwidth'
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
Plug 'hdima/python-syntax', {'for': 'python'}
Plug 'thinca/vim-ref'
Plug 'haya14busa/vim-asterisk'
Plug 'bling/vim-airline'
Plug 'ompugao/vim-airline-cwd'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ompugao/ctrlp-history'
Plug 'ompugao/ctrlp-locate'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'ompugao/cpsm', {'branch': 'feature/remove_boost_dependency', 'do': './install.sh' }
Plug 'lambdalisue/kensaku.vim'
Plug 'ompugao/ctrlp-kensaku'
Plug 'lambdalisue/vim-mr'
Plug 'tsuyoshicho/ctrlp-mr.vim'
Plug 'img-paste-devs/img-paste.vim'
Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton'
Plug 'NI57721/skkeleton-henkan-highlight'
Plug 'kshenoy/vim-signature'
Plug 'Shougo/vinarise', {'on': 'Vinarize'}
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/webapi-vim'
Plug 'tyru/open-browser.vim'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'mopp/autodirmake.vim'
Plug 'mattn/emmet-vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'vim-airline/vim-airline-themes'
Plug 'cohama/agit.vim'
Plug 'mattn/vim-molder'
Plug 'mattn/vim-molder-operations'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'skywind3000/asyncrun.vim'
Plug 'cocopon/iceberg.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/everforest'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rhysd/vim-clang-format'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'thomasfaingnaert/vim-lsp-neosnippet'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'mattn/vim-lsp-settings'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ompugao/patto', {'for': 'patto'}
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'ompugao/quickdict.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/tagbar'
Plug 'lambdalisue/gina.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()
"}}}

" settings {{{
augroup mysettings
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup END
set autoindent
set backup
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimswap
set diffopt+=vertical
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
augroup swapchoice-readonly
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
augroup END
if has('persistent_undo')
    set undodir=$HOME/.vimundo
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
    set undofile
endif
set list
set listchars=tab:>-,trail:_,nbsp:%
set scrolloff=4
set ignorecase
set smartcase
set showcmd
set laststatus=2
set ts=4
set sw=4
set smarttab
set noexpandtab
au FileType h,cpp,cuda,vim set expandtab
set incsearch
set hlsearch
set wrap
if has('linebreak')
    set breakindent
    set breakindentopt=min:50,shift:4,sbr
    set showbreak=↪
endif
set display=lastline
syntax enable
set showtabline=2
set switchbuf=useopen
set infercase
set hidden
set vb t_vb=
set virtualedit+=block
set nrformats+=unsigned
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamedplus,autoselect
    else
        set clipboard^=unnamed
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
set backspace=indent,eol,start
set history=10000
set foldenable
set foldmethod=marker
set shortmess-=S
augroup myfiletypes
    au!
    au BufNewFile,BufRead *.l set filetype=lisp
    au FileType lisp setlocal commentstring=\;%s
    au FileType python setlocal commentstring=\ \#%s
    au FileType ruby setlocal commentstring=\ \#%s
    au FileType markdown setlocal commentstring=\ <!--\ %s\ -->
    au BufNewFile,BufRead *.launch set filetype=launch syntax=xml
    au FileType launch setlocal commentstring=\ <!--\ %s\ -->
augroup END
set shellslash
set isfname&
            \ isfname+=@-@
            \ isfname-==
set grepprg=grep\ -nH\ $*
let g:tex_conceal = ""
augroup vimrc-auto-cursorline
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
augroup END
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
set t_BE=
augroup highlight_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
                \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo
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
noremap ; :
noremap : ;
nnoremap <C-]> g<C-]>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-X> <C-R>=<SID>GetBufferDirectory()<CR>
function! s:GetBufferDirectory()
    let path = expand('%:p:h')
    return path . (exists('+shellslash') && !&shellslash ? '\' : '/')
endfunction
cnoremap <C-T> <C-R>=strftime('%Y-%m-%d')<CR>
cabbr w!! w !sudo tee > /dev/null %
nnoremap <Leader>y my:0,$!xsel -iob<CR>u`y
"}}}

" fugitive {{{
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
nnoremap <silent> <leader>r <cmd>:QuickRun<CR>
"}}}

" neosnippet {{{
let g:neosnippet#snippets_directory='~/.vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_or_jump)
nmap <C-k>     <Plug>(neosnippet_expand_or_jump)
" }}}

if has('conceal')
  set conceallevel=2 concealcursor=c
endif

" indentLine {{{
let g:indentLine_fileTypeExclude=['dirvish', 'gina-status']
let g:indentLine_concealcursor='c'
let g:indentLine_setConceal = 0
" }}}

" asynccomplete {{{
set updatetime=300
let g:lsp_work_done_progress_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_diagnostics_virtual_text_wrap = 'truncate'

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal completeopt-=preview
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'allowlist': ['*'],
            \ 'blocklist': ['patto'],
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
            \ 'blocklist': ['patto'],
            \ 'priority': 5,
            \ 'min_chars': 1,
            \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
            \ }))

set completeopt=menuone,noinsert,noselect
set pumheight=12

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let s:auto_popup_filetypes = ['make', 'markdown', 'shell', 'docker', 'rust', 'patto']
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
let g:lsp_show_document = 1
let g:lsp_signs_enabled = 0
let g:lsp_signs_error = {'text': 'XX'}
let g:lsp_signs_warning = {'text': '!!'}
let g:lsp_auto_enable = 1
let g:lsp_hover_ui = 'float'
"}}}

" refe {{{
let g:ref_use_vimproc=1
let g:ref_refe_version=2
nnoremap <Space>rr  :<C-u>Ref refe<Space>
nnoremap <Space>rm  :<C-u>Ref man<Space>
nnoremap <Space>rpy :<C-u>Ref pydoc<Space>
nnoremap <Space>rw  :<C-u>Ref webdict<Space>
let g:ref_source_webdict_sites = {
            \   'je': { 'url': 'http://dictionary.infoseek.ne.jp/jeword/%s' },
            \   'ej': { 'url': 'http://dictionary.infoseek.ne.jp/ejword/%s' },
            \   'wiki': { 'url': 'http://ja.wikipedia.org/wiki/%s' },
            \   'alc': { 'url': 'http://eow.alc.co.jp/search?q=%s' },
            \   'weblio': { 'url': 'http://www.weblio.jp/content/%s' },
            \   'thesaurus': { 'url': 'http://thesaurus.weblio.jp/content/%s' },
            \   'antonym': { 'url': 'http://thesaurus.weblio.jp/antonym/content/%s' }
            \ }
let g:ref_source_webdict_sites.default = 'alc'
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
    return substitute(join(split(a:output, "\n")[106 :], "\n"), '｛.\{-}｝', '', 'g')
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
let g:grepper = {}
let g:grepper.stop = 10000
let g:grepper.rg = {'grepprg': 'rg -H --no-heading --vimgrep --smart-case -g "!tags"'}
noremap <Space>gg :<C-u>Grepper -tool git<CR>
noremap <Space>gi :<C-u>Grepper -tool rg<CR>
noremap <Space>g* :<C-u>Grepper -tool rg -cword -noprompt<CR>
"}}}

" airline {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_experimental = 1
let g:airline_extensions = ['branch', 'gina', 'ctrlp', 'quickfix', 'wordcount', 'gutentags', 'cwd', 'lsp', 'tabline']
let g:airline_theme='everforest'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat='\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#disable_rtp_load = 0
let g:airline#extensions#cwd#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79, 'x': 80, 'y': 88, 'z': 60 }
let g:airline#extensions#whitespace#enabled = 1
let g:airline_mode_map = {
            \ '__' : '-', 'n'  : 'N', 'i'  : 'I', 'R'  : 'R',
            \ 'c'  : 'C', 'v'  : 'v', 'V'  : 'V', '' : '^V',
            \ 's'  : 's', 'S'  : 'S', '' : '^' }
" }}}

" colorscheme {{{
set background=dark
set termguicolors
colorscheme everforest
set t_Co=256
highlight MatchParen term=standout ctermbg=LightGrey ctermfg=lightcyan guibg=LightGrey guifg=lightcyan
highlight Normal ctermbg=none
let g:netrw_liststyle = 3
let lisp_rainbow = 1
"}}}

" fzf {{{
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']
let g:fzf_layout = { 'down': '~40%' }
let $FZF_DEFAULT_OPTS .= ' --info=hidden --keep-right '
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)
function! s:fzfhistory(...)
    return fzf#run(fzf#wrap('history-files', {
                \ 'source':  fzf#vim#_recent_files(),
                \ 'options': ['-m', '--info=hidden', '--header-lines', !empty(expand('%')), '--prompt', 'Hist> ',
                \ '--preview', "basename {}", '--preview-window', "down:1:noborder"]
                \}))
endfunction
command! -bang -nargs=? FileHistory call s:fzfhistory(<q-args>, <bang>0)
augroup fzfconf
    autocmd!
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" }}}

" ctrlp {{{
let g:ctrlp_map = '<c-l><c-p>'
nnoremap <silent><C-l><C-p> :<C-u>CtrlP<CR>
nnoremap <silent><C-l><C-s> :execute ':<C-u>CtrlP <C-r>=expand('%:h:p')<CR><CR>'
nnoremap <silent><C-l><C-b> :<C-u>CtrlPBuffer<CR>
nnoremap <silent><C-l><C-r> :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><C-m> :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><CR>  :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><C-d> :<C-u>CtrlPDir<CR>
nnoremap <silent><C-l><C-c> :<C-u>CtrlPQuickfix<CR>
nnoremap <silent><C-l><C-h> :<C-u>CtrlPCmdHistory<CR>
nnoremap <silent><C-l>/     :<C-u>CtrlPSearchHistory<CR>
nnoremap <silent><C-l>l     :<C-u>CtrlPLocate<CR>
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_use_caching = 1
if executable('rg')
    let g:ctrlp_user_command = 'rg --hidden --files %s | rg -v -e "\.git/" -e "\.exe$" -e "\.so$" -e "\.dll$" -e "\.db$" -e "\.o$" -e "\.a$" -e "\.pyc$" -e "\.pyo$" -e "\.pdf$" -e "\.dvi$" -e "\.zip$" -e "\.rar$" -e "\.tgz$" -e "\.gz$" -e "\.tar$" -e "\.png$" -e "\.jpg$" -e "\.JPG$" -e "\.gif$" -e "\.mpg$" -e "\.mp4$" -e "\.mp3$" -e "\.bag$"'
endif
let g:ctrlp_max_files = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_prompt_mappings = { 'ToggleMRURelative()': ['<F2>'], 'ToggleKeyLoop()': ['<F3>'] }
let g:ctrlp_mruf_max = 1000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|neocon|cache|Skype|fontconfig|vimbackup|nvimbackup|wine|thumbnail|mozilla|local|thunderbird|vimundo|nvimundo|neocomplcache|rvm|cache|vimswap|nvimswap|rbenv)$',
            \ 'file': '\v(\.(exe|so|dll|db|o|a|pyc|pyo|pdf|dvi|zip|rar|tgz|gz|tar|png|jpg|JPG|gif|mpg|mp4|mp3|bag|sw[a-z])|tags)$',
            \ }
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|vimfiler\|unite\|vimshell'
let g:ctrlp_lazy_update = 0
let g:ctrlp_key_loop = 0
let g:ctrlp_funky_sort_reverse=1
let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_tjump_only_silent = 1
let g:ctrlp_user_command_async = 1
if exists('*matchfuzzy')
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif
if has('python3')
    let g:cpsm_match_empty_query = 0
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
endif
function! s:kensaku() abort
    let l:oldmatcher = g:ctrlp_match_func
    let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
    let g:ctrlp_lazy_update = 100
    execute("CtrlP")
    let g:ctrlp_match_func = l:oldmatcher
    let g:ctrlp_lazy_update = 0
endfunction
command! CtrlPKensakuFiles call <SID>kensaku()
nnoremap <silent><C-l><C-k> :<C-u>CtrlPKensakuFiles<CR>
function! CtrlPToggleMRURelative() abort
    cal ctrlp#mrufiles#tgrel()
    let g:ctrlp_lines = ctrlp#mrufiles#refresh()
endfunction
function! CtrlPPreviewFunc(line) abort
    call system('flatpak run org.gnome.NautilusPreviewer '.. a:line)
endfunction
function! s:ctrlp_mru_kensaku_relative() abort
    let l:oldmatcher = g:ctrlp_match_func
    if !g:ctrlp_mruf_relative
        cal ctrlp#mrufiles#tgrel()
    endif
    let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
    execute("CtrlPMRU")
    let g:ctrlp_match_func = l:oldmatcher
    if g:ctrlp_mruf_relative
        cal ctrlp#mrufiles#tgrel()
    endif
endfunction
command! CtrlPRelativeMRUKensaku call <SID>ctrlp_mru_kensaku_relative()
nnoremap <silent><C-l><C-t> :<C-u>CtrlPRelativeMRUKensaku<CR>
let g:ctrlp_tjump_shortener = ['/home/[^/]*/', '~/']
"}}}

" vim-mr {{{
let g:mr#mru#predicates = [{ filename -> filename !~# '/tmp/editprompt-prompts' }]
" }}}

" openbrowser {{{
nmap <space>ob <Plug>(openbrowser-open)
xmap <space>ob <Plug>(openbrowser-open)
nmap <space>ow <Plug>(openbrowser-search)
nmap <space>os <Plug>(openbrowser-smart-search)
xmap <space>os <Plug>(openbrowser-smart-search)
"}}}

" molder {{{
let g:molder_show_hidden = 1
" }}}

" vim-easy-align {{{
xnoremap <silent> <Enter> :LiveEasyAlign<cr>
" }}}

" operator-replace {{{
nnoremap <silent> RR R
nnoremap <silent> R <Plug>(operator-replace)
xnoremap <silent> R <Plug>(operator-replace)
" }}}

" operator-surround {{{
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
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
vmap *  <Plug>(asterisk-*)
vmap g* <Plug>(asterisk-g*)
vmap #  <Plug>(asterisk-#)
vmap g# <Plug>(asterisk-g#)
" }}}

" previm {{{
let g:previm_enable_realtime = 1
"}}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}

" blockwise visual {{{
xnoremap <expr> I  <SID>force_blockwise_visual('I')
xnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
    if mode() ==# 'v'
        return "\<C-v>" . a:next_key
    elseif mode() ==# 'V'
        return "\<C-v>0o$" . a:next_key
    else
        return a:next_key
    endif
endfunction
"}}}

" tex {{{
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
augroup mytex
    autocmd BufWrite *.tex call s:TexReplaceChars()
augroup END
" }}}

" skkeleton {{{
set iminsert=0
function! s:skkeleton_init() abort
    call skkeleton#config({
                \ 'globalDictionaries': ['~/.skkjisyo/SKK-JISYO.L'],
                \ 'keepState': v:false,
                \ 'registerConvertResult': v:true,
                \ 'showCandidatesCount': 1,
                \ 'markerHenkan': '',
                \ 'markerHenkanSelect': ''
                \ })
    highlight SkkeletonHenkan gui=underline term=underline cterm=underline
    highlight SkkeletonHenkanSelect gui=underline,reverse term=underline,reverse cterm=underline,reverse
endfunction
augroup skkeleton-initialize-pre
    autocmd!
    autocmd User skkeleton-initialize-pre call s:skkeleton_init()
augroup END
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
"}}}

" oscyank {{{
let g:oscyank_silent = v:true
nnoremap <leader>Y <Plug>OSCYankOperator
nnoremap <leader>YY <leader>Y_
vnoremap <leader>Y <Plug>OSCYankVisual
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
" }}}

" clang-format {{{
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
" }}}

" cmake dictionary {{{
function! s:set_cmake_dictionary()
    let s:cmake_dict = printf('%s/dict/cmake.txt', expand('<sfile>:p:h'))
    if stridx(&l:dictionary, 'cmake\.txt$') == -1
        let &l:dictionary = printf('%s,%s', &l:dictionary, s:cmake_dict)
    endif
endfunction
autocmd FileType cmake call s:set_cmake_dictionary()
"}}}

" toggle terminal {{{
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
    setlocal nobuflisted
endfunction
inoremap <F2> <cmd>:call ToggleTerminal()<cr>
nnoremap <F2> <cmd>:call ToggleTerminal()<cr>
tnoremap <F2> <cmd>:call ToggleTerminal()<cr>
" }}}

" img-paste {{{
let g:mdip_imgdir = './assets'
function! g:PattoPasteImage(relpath)
    execute "normal! i[@img \"" . g:mdip_tmpname[0:0]
    let ipos = getcurpos()
    execute "normal! a" . g:mdip_tmpname[1:] . "\" " . a:relpath . "]"
    call setpos('.', ipos)
endfunction
augroup patto-imgpaste
    autocmd!
    autocmd FileType patto nmap <buffer> <leader>P <cmd>:call mdip#MarkdownClipboardImage()<CR>
    autocmd FileType patto let g:PasteImageFunction = 'g:PattoPasteImage'
augroup END
" }}}

filetype plugin indent on
