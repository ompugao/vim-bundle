if 0 | finish | endif
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf8

if has("nvim")
let g:loaded_python3_provider = 1
let g:python3_host_prog = ''
endif

" gutentags {{{
let g:gutentags_cache_dir=expand('~') . '/.gutentags'
let g:gutentags_ctags_extra_args = ['--excmd=number']
if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, "p")
endif
"let g:gutentags_trace = 1
" }}}

" Strange character since last update (>4;2m) in vim - Stack Overflow https://stackoverflow.com/questions/62148994/strange-character-since-last-update-42m-in-vim
" https://stackoverflow.com/questions/62148994/strange-character-since-last-update-42m-in-vim
let &t_TI = ""
let &t_TE = ""

" plugins {{{
call plug#begin()
if has('nvim')
  Plug 'stevearc/dressing.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'olimorris/codecompanion.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
else
  Plug 'github/copilot.vim'
endif
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
" Plug 'haya14busa/vim-migemo'
Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton'
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
Plug 'ivalkeen/vim-ctrlp-tjump'
" Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline-themes'
Plug 'cohama/agit.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'mattn/vim-molder'
Plug 'mattn/vim-molder-operations'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'skywind3000/asyncrun.vim'
Plug 'cocopon/iceberg.vim'
" Plug 'ompugao/harlequin'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/everforest'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rhysd/vim-clang-format'
if has('nvim')
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
  Plug 'rafamadriz/friendly-snippets'
  "Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'folke/trouble.nvim'
  Plug 'ompugao/patto'
else
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
endif
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'ompugao/quickdict.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/tagbar'
Plug 'lambdalisue/gina.vim'
" Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
Plug 'stefandtw/quickfix-reflector.vim'
if has('nvim')
  Plug 'ojroques/nvim-osc52', {'branch': 'main'}
else
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
endif
call plug#end()
"}}}

" settings(set *** etc.etc...) {{{
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
    set clipboard=unnamedplus  " setup clipboard-osc later
else
    if has('clipboard')
        if has('unnamedplus')
            set clipboard=unnamedplus,autoselect 
        else
            set clipboard^=unnamed "無名レジスタだけでなく、*レジスタにもヤンク
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
set shortmess-=S  " show match counts
augroup myfiletypes
    " TODO FileType Eventで
    au!
    au BufNewFile,BufRead *.l set filetype=lisp
    au FileType lisp setlocal commentstring=\;%s
    au FileType python setlocal commentstring=\ \#%s
    au FileType ruby setlocal commentstring=\ \#%s
    au FileType markdown setlocal commentstring=\ <!--\ %s\ -->
    au BufNewFile,BufRead *.launch set filetype=launch syntax=xml
    au FileType launch setlocal commentstring=\ <!--\ %s\ -->
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
cnoremap <C-T> <C-R>=strftime('%Y-%m-%d')<CR>
cabbr w!! w !sudo tee > /dev/null %
" yank to clipboard via xsel
nnoremap <Leader>y my:0,$!xsel -iob<CR>u`y
" "switched to oscyank plugin
" if executable('kitty')
"   nnoremap <leader>Y :call system('kitty +kitten clipboard', @0)<CR>
"   xnoremap <leader>Y :call system('kitty +kitten clipboard', @0)<CR>
" else
"   " clipper https://github.com/wincent/clipper
"   nnoremap <leader>Y :call system('nc -N localhost 8377', @0)<CR>
"   xnoremap <leader>Y :call system('nc -N localhost 8377', @0)<CR>
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
nnoremap <silent> <leader>r <cmd>:QuickRun<CR>
"}}}
if has('nvim')
  " luasnip {{{
  lua require("luasnip.loaders.from_vscode").lazy_load()
  lua require("luasnip.loaders.from_vscode").lazy_load({ paths = { '~/.config/nvim/snippets/' } }) -- Load snippets from my-snippets folder
  " press <Tab> to expand or jump in a snippet. These can also be mapped separately
  " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
  imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
  " -1 for jumping backwards.
  inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

  snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

  " For changing choices in choiceNodes (not strictly necessary for a basic setup).
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  " }}}
else
  " neosnippet {{{
  let g:neosnippet#snippets_directory='~/.vim/snippets'
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_or_jump)
  nmap <C-k>     <Plug>(neosnippet_expand_or_jump)
  " For snippet_complete marker.
  if has('conceal')
      set conceallevel=2 concealcursor=c
      let g:indentLine_fileTypeExclude=['dirvish', 'gina-status']
      let g:indentLine_concealcursor='c'
      let g:indentLine_setConceal = 0
  endif
  " }}}
endif
if has('nvim')
" nvim-cmp {{{
set completeopt=menuone,noinsert,noselect
set pumheight=10 "set the height of completion menu
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'
  local luasnip = require'luasnip'
  local cmp_setup = function(enable_compl)
    cmp.setup({
      enabled = enable_compl,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
        { name = 'path' },
      })
    })
  end
  cmp_setup(true)

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --[[cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })]]--

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --[[cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })]]--

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('patto')
  require('lspconfig.configs').patto_lsp.setup({
    capabilities = capabilities
  })
  require'lspconfig'.rust_analyzer.setup{
      capabilities = capabilities,
      settings = {
          ['rust-analyzer'] = {
              diagnostics = {
                  enable = false;
              }
          }
      }
  }
  require "lspconfig".pylsp.setup {
    settings = {
      pylsp = {
        plugins = {
          flake8 = {
            enabled = false,
            maxLineLength = 119,
          },
          mypy = {
            enabled = true,
          },
          pycodestyle = {
            enabled = false,
          },
          pyflakes = {
            enabled = false,
          },
        }
      }
    }
  }
  require "lspconfig".clangd.setup {}
  require "trouble".setup()

  vim.lsp.set_log_level('debug')
  vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function()
            local bufmap = function(mode, lhs, rhs)
            local opts = {buffer = true}
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
          bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
          bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
          bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
          bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
          bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
          bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
          bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
          bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
          bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
          bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
          bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
          end
  })
  vim.api.nvim_create_augroup('skkeleton-nvim-cmp', {})
  vim.api.nvim_create_autocmd('User', {
      group = 'skkeleton-nvim-cmp',
      pattern = 'skkeleton-enable-pre',
      callback = function()
        cmp_setup(false)
      end
  })
  vim.api.nvim_create_autocmd('User', {
      group = 'skkeleton-nvim-cmp',
      pattern = 'skkeleton-disable-pre',
      callback = function()
        cmp_setup(true)
      end
  })
EOF
" }}}
else
"asynccomplete {{{
set updatetime=300
let g:lsp_work_done_progress_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_diagnostics_virtual_text_wrap = 'truncate'

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    "setlocal signcolumn=yes
    setlocal completeopt-=preview
    "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
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
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
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
if !has('nvim')
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
              \ 'name': 'neosnippet',
              \ 'whitelist': ['*'],
              \ 'blocklist': ['patto'],
              \ 'priority': 5,
              \ 'min_chars': 1,
              \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
              \ }))
endif

set completeopt=menuone,noinsert,noselect
set pumheight=20 "set the height of completion menu

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
"let g:asyncomplete_auto_popup = 1
let s:auto_popup_filetypes = ['make', 'markdown', 'shell', 'docker', 'rust', 'patto']
"au InsertEnter * let g:asyncomplete_auto_popup = index(s:auto_popup_filetypes, &ft) > 1
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
let g:lsp_signs_enabled = 0         " enable signs
let g:lsp_signs_error = {'text': 'XX'}
let g:lsp_signs_warning = {'text': '!!'}
let g:lsp_auto_enable = 1
let g:lsp_hover_ui = 'float'
"}}}
endif
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
let g:airline_experimental = 1
let g:airline_extensions = ['branch', 'gina', 'ctrlp', 'quickfix', 'tabline', 'wordcount', 'gutentags', 'cwd']
if has('nvim')
  let g:airline_extensions = add(g:airline_extensions, 'nvimlsp')
else
  let g:airline_extensions = add(g:airline_extensions, 'lsp')
endif
let g:airline_theme='ayu_mirage' "'minimalist' 'serene' 'simple' 'wombat''papercolor'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = 'LF'
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
if has('nvim')
  set notermguicolors
endif
"colorscheme PaperColor
colorscheme everforest
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
"let $FZF_DEFAULT_OPTS .= ' --info=inline --keep-right '
let $FZF_DEFAULT_OPTS .= ' --info=hidden --keep-right '
"let g:fzf_files_options='--info=inline --preview "basename {}" --preview-window "down:1:noborder"'
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
nnoremap <silent><C-l><C-r> :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><C-m> :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><CR>  :<C-u>CtrlPMRMru<CR>
nnoremap <silent><C-l><C-d> :<C-u>CtrlPDir<CR>
"nnoremap <silent><C-l><C-k> :execute ':<C-u>CtrlPDir <C-r>=expand('%:h:p')<CR><CR>'
nnoremap <silent><C-l><C-c> :<C-u>CtrlPQuickfix<CR>
"nnoremap <silent><C-l>f     :<C-u>CtrlPFunky<Cr>
nnoremap <silent><C-l><C-h> :<C-u>CtrlPCmdHistory<CR>
nnoremap <silent><C-l>/     :<C-u>CtrlPSearchHistory<CR>
nnoremap <silent><C-l>l     :<C-u>CtrlPLocate<CR>
"nnoremap <silent><C-l><C-t> :<C-u>CtrlPSmartTabs<CR>
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
"\ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.neocon$\|\.cache$\|\.Skype$\|\.fontconfig$\|\.vimbackup$\|\.wine$\|\.thumbnails$\|\.mozilla$\|\.local$\|\.thunderbird$\|\.vimundo$\|\.neocomplcache$\|\.rvm$\|\.cache$\|\.vimswap$|\.rbenv$',
"\ 'file': '\.exe$\|\.so$\|\.dll$\|\.db$\|\.o$\|\.a$\|\.pyc$\|\.pyo$\|\.pdf$\|\.dvi$\|\.zip$\|\.rar$\|\.tgz$\|\.gz$\|\.tar$\|\.png$\|\.jpg$\|\.JPG$\|\.gif$\|\.mpg$\|\.mp4$\|\.mp3$\|\.bag$\|\.sw[a-z]$',
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|vimfiler\|unite\|vimshell'
let g:ctrlp_lazy_update = 0
let g:ctrlp_key_loop = 0
let g:ctrlp_funky_sort_reverse=1
let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_tjump_only_silent = 1
let g:ctrlp_user_command_async = 1
" if has('python3')
"   let g:fruzzy#usenative = 1
"   let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
" elseif exists('*matchfuzzy')
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


" let g:ctrlp_mruf_default_order = 1
" function! Ctrlp_toggle_mrf_order() abort
"   let g:ctrlp_mruf_default_order=!g:ctrlp_mruf_default_order
"   echo 'mru_sort: ' . g:ctrlp_mruf_default_order
"   let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
"   call ctrlp#update(1)
" endfunction
function! CtrlPToggleMRURelative() abort
    cal ctrlp#mrufiles#tgrel()
    let g:ctrlp_lines = ctrlp#mrufiles#refresh()
endfunction
function! CtrlPPreviewFunc(line) abort
    call system('flatpak run org.gnome.NautilusPreviewer '.. a:line)
endfunction
function! s:ctrlp_mru_kensaku_relative() abort
    let l:oldmatcher = g:ctrlp_match_func
    "let g:ctrlp_mruf_default_order = 1
    if !g:ctrlp_mruf_relative
        cal ctrlp#mrufiles#tgrel()
    endif
    let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
    "let g:ctrlp_move_func = {'main': 'CtrlPPreviewFunc'}
    "execute("CtrlP")
    execute("CtrlPMRU")
    let g:ctrlp_match_func = l:oldmatcher
    "unlet g:ctrlp_move_func
    "let g:ctrlp_mruf_default_order = 0
    if g:ctrlp_mruf_relative
        cal ctrlp#mrufiles#tgrel()
    endif
endfunction
command! CtrlPRelativeMRUKensaku call <SID>ctrlp_mru_kensaku_relative()
nnoremap <silent><C-l><C-t> :<C-u>CtrlPRelativeMRUKensaku<CR>

let g:ctrlp_tjump_shortener = ['/home/[^/]*/', '~/']
"if exists(':CtrlPtjump')
"  let g:ctrlp_tjump_only_silent=1
"  nnoremap <c-]> :CtrlPtjump<cr>
"  xnoremap <c-]> :CtrlPtjumpVisual<cr>
"endif
"}}}
"openbrowser"{{{
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap <space>ob <Plug>(openbrowser-open)
xmap <space>ob <Plug>(openbrowser-open)
nmap <space>ow <Plug>(openbrowser-search)
nmap <space>os <Plug>(openbrowser-smart-search)
xmap <space>os <Plug>(openbrowser-smart-search)
"}}}
" molder {{{
let g:molder_show_hidden = 1
" }}}
" vim-easy-align{{{
xnoremap <silent> <Enter> :LiveEasyAlign<cr>
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
"{{{
xnoremap <expr> I  <SID>force_blockwise_visual('I')
xnoremap <expr> A  <SID>force_blockwise_visual('A')
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
augroup mytex
    autocmd BufWrite *.tex call s:TexReplaceChars()
augroup END
" }}}
" eskk{{{
let g:eskk#show_annotation=1
let g:eskk#large_dictionary = {
            \	'path': "~/.skkjisyo/SKK-JISYO.L",
            \	'sorted': 1,
            \	'encoding': 'euc-jp',
            \}
set iminsert=0
function! s:skkeleton_init() abort
    call skkeleton#config({
                \ 'globalDictionaries': ['~/.skkjisyo/SKK-JISYO.L'],
                \ 'keepState': v:false,
                \ 'registerConvertResult': v:true,
                \ 'showCandidatesCount': 1
                \ })
endfunction
augroup skkeleton-initialize-pre
    autocmd!
    autocmd User skkeleton-initialize-pre call s:skkeleton_init()
augroup END
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
"if executable('ibus')
"    augroup IbusControl
"        au!
"        au InsertLeave * call system('ibus engine skk')
"        au VimEnter,InsertEnter * call system('ibus engine xkb:us::eng')
"    augroup END
"endif
"}}}
" oscyank {{{
if has('nvim')
    lua << EOF
    require('osc52').setup {
        max_length = 0,           -- Maximum length of selection (0 for no limit)
        silent = true,           -- Disable message on successful copy
        trim = false,             -- Trim surrounding whitespaces before copy
        tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
    }
    -- vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
    -- vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
    -- vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
    local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
    end

    local function paste()
        return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
    end

    vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
    }

    -- Now the '+' register will copy to system clipboard using OSC52
    vim.keymap.set('n', '<leader>c', '"+y')
    vim.keymap.set('n', '<leader>cc', '"+yy')
EOF
else
  let g:oscyank_silent = v:true
  nnoremap <leader>Y <Plug>OSCYankOperator
  nnoremap <leader>YY <leader>Y_
  vnoremap <leader>Y <Plug>OSCYankVisual
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
endif
" }}}
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
        setlocal nobuflisted
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
        setlocal nobuflisted
    endfunction
endif

inoremap <F2> <cmd>:call ToggleTerminal()<cr>
nnoremap <F2> <cmd>:call ToggleTerminal()<cr>
tnoremap <F2> <cmd>:call ToggleTerminal()<cr>
" }}}
" img-paste {{{
let g:mdip_imgdir = './assets'
"let g:mdip_imgname = 'image'
function! g:PattoPasteImage(relpath)
    execute "normal! i[@img \"" . g:mdip_tmpname[0:0]
    let ipos = getcurpos()
    execute "normal! a" . g:mdip_tmpname[1:] . "\" " . a:relpath . "]"
    call setpos('.', ipos)
    "execute "normal! vt]\<C-g>"
endfunction
augroup patto-imgpaste
    autocmd!
    autocmd FileType patto nmap <buffer> <leader>P <cmd>:call mdip#MarkdownClipboardImage()<CR>
    autocmd FileType patto let g:PasteImageFunction = 'g:PattoPasteImage'
augroup END
" }}}

if has('nvim')
" codecompanion {{{
lua << EOF
require("copilot").setup()
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
  },
})
EOF
" }}}
endif
filetype plugin indent on
