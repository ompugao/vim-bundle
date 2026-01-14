-- Neovim Configuration (Lua)
-- Ported from vimrc, utilizing lazy.nvim properly

-- Basic Settings
vim.o.encoding = 'utf-8'
vim.o.fileencodings = 'utf-8,iso-2022-jp,euc-jp,sjis'
vim.o.fileformats = 'unix,dos,mac'
vim.scriptencoding = 'utf8'

-- Disable Python provider
vim.g.loaded_python3_provider = 0
vim.g.python3_host_prog = ''

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  -- UI & Appearance
  { 'stevearc/dressing.nvim', opts = {} },
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'cocopon/iceberg.vim', lazy = true },
  { 'NLKNguyen/papercolor-theme', lazy = true },
  { 'sainnhe/everforest', lazy = false, priority = 1000 },

  { 'romgrk/barbar.nvim',
    lazy = false,
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = false,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      focus_on_close = 'left',
      hide = { extensions = false, inactive = false },
      highlight_alternate = false,
      highlight_inactive_file_icons = false,
      highlight_visible = true,
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = true },
        },
        gitsigns = {
          added = { enabled = true, icon = '+' },
          changed = { enabled = true, icon = '~' },
          deleted = { enabled = true, icon = '-' },
        },
        filetype = { custom_colors = false, enabled = false },
        separator = { left = '▎', right = '' },
        separator_at_end = true,
        modified = { button = '●' },
        pinned = { button = '', filename = true },
        preset = 'default',
        alternate = { filetype = { enabled = true } },
        current = { buffer_index = false },
        inactive = { button = '×' },
        visible = { modified = { buffer_number = true } },
      },
      insert_at_end = false,
      insert_at_start = false,
      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 30,
      minimum_length = 0,
      semantic_letters = true,
      letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
      sort = { ignore_case = true },
    },
    keys = {
      { '<C-n>', '<Cmd>BufferNext<CR>', desc = 'Next buffer' },
      { '<C-p>', '<Cmd>BufferPrevious<CR>', desc = 'Previous buffer' },
    },
  },

  { 'j-hui/fidget.nvim', opts = {} },

  { 'shellRaining/hlchunk.nvim',
    event = 'BufReadPost',
    opts = {
      chunk = { enable = true, priority = 15, style = "#c21f30" },
      indent = { enable = true, priority = 10 },
    },
  },

  { 'yorickpeterse/nvim-pqf', opts = {} },

  -- Copilot
  { 'zbirenbaum/copilot.lua', cmd = 'Copilot', event = 'InsertEnter', opts = {} },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Snippets
  { 'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { '~/.config/nvim/snippets/' } })
    end,
    keys = {
      { '<Tab>', function()
        return require('luasnip').expand_or_jumpable() and '<Plug>luasnip-expand-or-jump' or '<Tab>'
      end, mode = 'i', expr = true, silent = true },
      { '<C-k>', function()
        return require('luasnip').expand_or_jumpable() and '<Plug>luasnip-expand-or-jump' or '<Tab>'
      end, mode = 'i', expr = true, silent = true },
      { '<S-Tab>', function() require('luasnip').jump(-1) end, mode = 'i', silent = true },
      { '<C-k>', function() require('luasnip').jump(1) end, mode = 's', silent = true },
      { '<Tab>', function() require('luasnip').jump(1) end, mode = 's', silent = true },
      { '<S-Tab>', function() require('luasnip').jump(-1) end, mode = 's', silent = true },
      { '<C-E>', function()
        return require('luasnip').choice_active() and '<Plug>luasnip-next-choice' or '<C-E>'
      end, mode = { 'i', 's' }, expr = true, silent = true },
    },
  },

  -- Completion
  { 'saghen/blink.cmp',
    branch = 'main',
    build = 'cargo +nightly b -r',
    dependencies = {
      { 'saghen/blink.compat', branch = 'main', opts = {} },
      'Xantibody/blink-cmp-skkeleton',
      { 'biosugar0/cmp-claudecode',
        opts = {
          enabled = { custom = function() return vim.env.EDITPROMPT == '1' end },
        },
      },
    },
    opts = {
      snippets = { preset = 'luasnip' },
      cmdline = { keymap = { preset = 'cmdline' } },
      keymap = { preset = 'enter', ["<Space>"] = {} },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = { max_height = 12 },
        documentation = { auto_show = false },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = { 'exact', 'score', 'sort_text' },
      },
      sources = {
        default = function(_ctx)
          if require("blink-cmp-skkeleton").is_enabled() then
            return { "skkeleton", "lsp" }
          else
            return { 'lsp', 'snippets', 'path', 'buffer', 'claude_slash', 'claude_at' }
          end
        end,
        per_filetype = {
          markdown = function(_ctx)
            if require("blink-cmp-skkeleton").is_enabled() then
              return { "skkeleton", "lsp" }
            else
              return { 'lsp', 'snippets', 'path', 'claude_slash', 'claude_at' }
            end
          end,
          patto = function(_ctx)
            if require("blink-cmp-skkeleton").is_enabled() then
              return { "skkeleton", "lsp" }
            else
              return { 'lsp', 'snippets', 'path', 'claude_slash', 'claude_at' }
            end
          end,
        },
        providers = {
          skkeleton = { name = 'skkeleton', module = 'blink-cmp-skkeleton' },
          claude_slash = { name = 'claude_slash', module = 'blink.compat.source', score_offset = 20 },
          claude_at = { name = 'claude_at', module = 'blink.compat.source', score_offset = 20 },
        },
      },
    },
    config = function(_, opts)
      vim.g.skkeleton_blink_mode = false
      local blink = require('blink.cmp')
      blink.setup(opts)

      -- LSP capabilities
      local capabilities = blink.get_lsp_capabilities({
        textDocument = {
          completion = { completionItem = { snippetSupport = true } },
          foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
        },
      })
      vim.lsp.config('*', { capabilities = capabilities, virtual_text = false })
    end,
  },

  -- LSP
  { 'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.lsp.config('patto_lsp', {
        on_init = function(client)
          local stp = client.server_capabilities.semanticTokensProvider
          if stp then stp.range = false end
        end,
      })
      vim.lsp.config('patto_preview', {})
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = { enable = false },
            check = { command = "clippy" },
          },
        },
      })
      vim.lsp.config('clangd', {})
      vim.lsp.config('pyright', {})
      vim.lsp.enable({ 'rust_analyzer', 'pyright', 'clangd', 'patto_lsp', 'patto_preview' })

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
          end
          bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
          bufmap('n', 'gd', '<cmd>Trouble lsp_definitions<cr>')
          bufmap('n', 'gD', '<cmd>Trouble lsp_declarations<cr>')
          bufmap('n', 'gi', '<cmd>Trouble lsp_implementations<cr>')
          bufmap('n', 'go', '<cmd>Trouble lsp_type_definitions<cr>')
          bufmap('n', 'gr', '<cmd>Trouble lsp_references<cr>')
          bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
          bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
          bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
          bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
          bufmap('n', '[d', '<cmd>lua vim.diagnostic.jump({count=-1, float=false})<cr>')
          bufmap('n', ']d', '<cmd>lua vim.diagnostic.jump({count=1, float=false})<cr>')
          bufmap('n', 'g=', '<cmd>lua vim.lsp.buf.format()<cr>')
        end,
      })
    end,
  },

  { 'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = { preview = { scratch = false } },
  },

  { 'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    opts = {
      preset = "simple",
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "Normal",
      },
    },
  },

  -- Git
  { 'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gvdiff' },
    init = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = 'fugitive://*',
        callback = function() vim.bo.bufhidden = 'delete' end,
      })
    end,
  },
  { 'lewis6991/gitsigns.nvim', event = 'BufReadPre', opts = {} },
  { 'cohama/agit.vim', cmd = 'Agit' },
  { 'lambdalisue/gina.vim', cmd = 'Gina' },

  -- Fuzzy Finder
  { 'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      },
    },
    opts = {
      defaults = {
        layout_strategy = 'bottom_pane',
        layout_config = { height = 0.50, prompt_position = 'bottom', width = 0.99 },
        border = false,
      },
    },
  },

  { 'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    opts = {
      winopts = {
        split = "belowright new",
        border = "none",
        preview = { border = "none", title = false },
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--info"] = "hidden",
        ["--height"] = "100%",
        ["--layout"] = "default",
        ["--border"] = "none",
        ["--highlight-line"] = true,
        ["--keep-right"] = true,
      },
    },
  },

  { 'junegunn/fzf',
    build = function() vim.fn['fzf#install']() end,
    init = function()
      vim.g.fzf_preview_window = { 'right:40%:hidden', 'ctrl-/' }
      vim.g.fzf_layout = { down = '~40%' }
      vim.env.FZF_DEFAULT_OPTS = (vim.env.FZF_DEFAULT_OPTS or '') .. ' --info=hidden --keep-right '
    end,
  },
  { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },

  { 'ctrlpvim/ctrlp.vim',
    init = function()
      vim.g.ctrlp_map = '<c-l><c-p>'
      vim.g.ctrlp_cmd = 'CtrlP'
      vim.g.ctrlp_use_caching = 1
      if vim.fn.executable('rg') == 1 then
        vim.g.ctrlp_user_command = 'rg --hidden --files %s | rg -v -e "\\.git/" -e "\\.exe$" -e "\\.so$" -e "\\.dll$" -e "\\.db$" -e "\\.o$" -e "\\.a$" -e "\\.pyc$" -e "\\.pyo$" -e "\\.pdf$" -e "\\.dvi$" -e "\\.zip$" -e "\\.rar$" -e "\\.tgz$" -e "\\.gz$" -e "\\.tar$" -e "\\.png$" -e "\\.jpg$" -e "\\.JPG$" -e "\\.gif$" -e "\\.mpg$" -e "\\.mp4$" -e "\\.mp3$" -e "\\.bag$"'
      end
      vim.g.ctrlp_max_files = 0
      vim.g.ctrlp_show_hidden = 1
      vim.g.ctrlp_prompt_mappings = { ['ToggleMRURelative()'] = { '<F2>' }, ['ToggleKeyLoop()'] = { '<F3>' } }
      vim.g.ctrlp_mruf_max = 1000
      vim.g.ctrlp_clear_cache_on_exit = 0
      vim.g.ctrlp_mruf_exclude = '/tmp/.*\\|/temp/.*'
      vim.g.ctrlp_custom_ignore = {
        dir = [[\v[\/]\.(git|hg|svn|neocon|cache|Skype|fontconfig|vimbackup|nvimbackup|wine|thumbnail|mozilla|local|thunderbird|vimundo|nvimundo|neocomplcache|rvm|cache|vimswap|nvimswap|rbenv)$]],
        file = [[(\.(exe|so|dll|db|o|a|pyc|pyo|pdf|dvi|zip|rar|tgz|gz|tar|png|jpg|JPG|gif|mpg|mp4|mp3|bag|sw[a-z])|tags)$]],
      }
      vim.g.ctrlp_switch_buffer = 'Et'
      vim.g.ctrlp_reuse_window = 'netrw\\|help\\|quickfix\\|vimfiler\\|unite\\|vimshell'
      vim.g.ctrlp_lazy_update = 0
      vim.g.ctrlp_key_loop = 0
      vim.g.ctrlp_funky_sort_reverse = 1
      vim.g.ctrlp_smarttabs_modify_tabline = 1
      vim.g.ctrlp_tjump_only_silent = 1
      vim.g.ctrlp_user_command_async = 1
      vim.g.ctrlp_tjump_shortener = { '/home/[^/]*/', '~/' }
      if vim.fn.exists('*matchfuzzy') == 1 then
        vim.g.ctrlp_match_func = { match = 'ctrlp_matchfuzzy#matcher' }
      end
      if vim.fn.has('python3') == 1 then
        vim.g.cpsm_match_empty_query = 0
        vim.g.ctrlp_match_func = { match = 'cpsm#CtrlPMatch' }
      end
    end,
    keys = {
      { '<C-l><C-p>', ':<C-u>CtrlP<CR>', silent = true },
      { '<C-l><C-s>', ":execute ':<C-u>CtrlP ' .. expand('%:h:p')<CR>", silent = true },
      { '<C-l><C-b>', ':<C-u>CtrlPBuffer<CR>', silent = true },
      { '<C-l><C-r>', ':<C-u>CtrlPMRMru<CR>', silent = true },
      { '<C-l><C-m>', ':<C-u>CtrlPMRMru<CR>', silent = true },
      { '<C-l><CR>', ':<C-u>CtrlPMRMru<CR>', silent = true },
      { '<C-l><C-d>', ':<C-u>CtrlPDir<CR>', silent = true },
      { '<C-l><C-c>', ':<C-u>CtrlPQuickfix<CR>', silent = true },
      { '<C-l><C-h>', ':<C-u>CtrlPCmdHistory<CR>', silent = true },
      { '<C-l>/', ':<C-u>CtrlPSearchHistory<CR>', silent = true },
      { '<C-l>l', ':<C-u>CtrlPLocate<CR>', silent = true },
      { '<C-l><C-k>', ':<C-u>CtrlPKensakuFiles<CR>', silent = true },
      { '<C-l><C-t>', ':<C-u>CtrlPRelativeMRUKensaku<CR>', silent = true },
    },
    config = function()
      -- CtrlP Kensaku functions
      vim.cmd([[
        function! s:kensaku() abort
          let l:oldmatcher = g:ctrlp_match_func
          let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
          let g:ctrlp_lazy_update = 100
          execute("CtrlP")
          let g:ctrlp_match_func = l:oldmatcher
          let g:ctrlp_lazy_update = 0
        endfunction
        command! CtrlPKensakuFiles call <SID>kensaku()

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
      ]])
    end,
  },
  { 'ompugao/ctrlp-history', dependencies = { 'ctrlpvim/ctrlp.vim' } },
  { 'ompugao/ctrlp-locate', dependencies = { 'ctrlpvim/ctrlp.vim' } },
  { 'mattn/ctrlp-matchfuzzy', dependencies = { 'ctrlpvim/ctrlp.vim' } },
  { 'ompugao/cpsm', branch = 'feature/remove_boost_dependency', build = './install.sh', dependencies = { 'ctrlpvim/ctrlp.vim' } },
  { 'lambdalisue/kensaku.vim' },
  { 'ompugao/ctrlp-kensaku', dependencies = { 'ctrlpvim/ctrlp.vim', 'lambdalisue/kensaku.vim' } },
  { 'lambdalisue/vim-mr', init = function()
    vim.g['mr#mru#predicates'] = { function(filename) return not filename:match('/tmp/editprompt%-prompts') end }
  end },
  { 'tsuyoshicho/ctrlp-mr.vim', dependencies = { 'ctrlpvim/ctrlp.vim', 'lambdalisue/vim-mr' } },

  -- Operators & Text Objects
  { 'junegunn/vim-easy-align',
    keys = {
      { '<Enter>', ':LiveEasyAlign<CR>', mode = 'x', silent = true },
    },
  },
  { 'kana/vim-operator-user' },
  { 'kana/vim-textobj-user' },
  { 'kana/vim-operator-replace',
    dependencies = { 'kana/vim-operator-user' },
    keys = {
      { 'RR', 'R', silent = true },
      { 'R', '<Plug>(operator-replace)', silent = true },
      { 'R', '<Plug>(operator-replace)', mode = 'x', silent = true },
    },
  },
  { 'rhysd/vim-operator-surround',
    dependencies = { 'kana/vim-operator-user' },
    init = function()
      vim.g['operator#surround#blocks'] = {
        markdown = { { block = { "```\n", "\n```" }, motionwise = { 'line' }, keys = { '`' } } },
        ['-'] = { { block = { [[\<\[a-zA-z0-9_?!]\+\[(\[]], [=[\[)\]]=] }, motionwise = { 'char' }, keys = { 'c' } } },
      }
    end,
    keys = {
      { 'sa', '<Plug>(operator-surround-append)', mode = { 'n', 'x' }, silent = true },
      { 'sd', '<Plug>(operator-surround-delete)', mode = { 'n', 'x' }, silent = true },
      { 'sr', '<Plug>(operator-surround-replace)', mode = { 'n', 'x' }, silent = true },
    },
  },
  { 'thinca/vim-textobj-between', dependencies = { 'kana/vim-textobj-user' } },
  { 'haya14busa/vim-asterisk',
    keys = {
      { '*', '<Plug>(asterisk-*)', mode = 'x' },
      { 'g*', '<Plug>(asterisk-g*)', mode = 'x' },
      { '#', '<Plug>(asterisk-#)', mode = 'x' },
      { 'g#', '<Plug>(asterisk-g#)', mode = 'x' },
    },
  },

  -- Language Support
  { 'vim-ruby/vim-ruby', ft = 'ruby' },
  { 'hdima/python-syntax', ft = 'python' },
  { 'rust-lang/rust.vim', ft = 'rust' },
  { 'plasticboy/vim-markdown', ft = 'markdown', init = function()
    vim.g.vim_markdown_folding_disabled = 1
  end },
  { 'ompugao/patto' },

  -- Utilities
  { 'rbtnn/vim-ambiwidth' },

  { 'monaqa/dial.nvim',
    keys = {
      { '<C-a>', '<Plug>(dial-increment)', mode = { 'n', 'v' } },
      { '<C-x>', '<Plug>(dial-decrement)', mode = { 'n', 'v' } },
      { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' } },
      { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' } },
    },
  },

  { 'Shougo/vimproc', build = 'make' },

  { 'thinca/vim-quickrun',
    dependencies = { 'mattn/quickrunex-vim' },
    init = function()
      vim.g.quickrun_config = {
        ['_'] = {
          ['outputter/buffer/split'] = ':botright',
          ['outputter/buffer/close_on_empty'] = 1,
          runner = 'job',
          ['runner/job/interval'] = 60,
        },
        markdown = {
          type = 'markdown/pandoc',
          outputter = 'browser',
          cmdopt = '--mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML" -c $HOME/dotfiles/vim/misc/githublike.css -s',
        },
        coffee = { command = 'coffee', exec = { '%c -cbp %s' } },
        ['cpp/clang++11'] = { command = 'clang++', cmdopt = '--std=c++11 --stdlib=libc++', type = 'cpp/clang++' },
        ['cpp/g++11'] = {
          command = 'g++',
          exec = { '%c %o %s -o %s:p:r', '%s:p:r %a' },
          tempfile = '%{tempname()}.cpp',
          ['hook/sweep/files'] = '%S:p:r',
          cmdopt = '-std=c++11 ',
        },
        ['cpp/g++14'] = {
          command = 'g++',
          exec = { '%c %o %s -o %s:p:r', '%s:p:r %a' },
          tempfile = '%{tempname()}.cpp',
          ['hook/sweep/files'] = '%S:p:r',
          cmdopt = '-std=c++14 ',
        },
        octave = { command = 'octave' },
      }
    end,
    keys = {
      { '<leader>r', '<cmd>QuickRun<CR>', silent = true },
    },
  },

  { 'thinca/vim-ref',
    init = function()
      vim.g.ref_use_vimproc = 1
      vim.g.ref_refe_version = 2
      vim.g.ref_source_webdict_sites = {
        je = { url = 'http://dictionary.infoseek.ne.jp/jeword/%s' },
        ej = { url = 'http://dictionary.infoseek.ne.jp/ejword/%s' },
        wiki = { url = 'http://ja.wikipedia.org/wiki/%s' },
        alc = { url = 'http://eow.alc.co.jp/search?q=%s' },
        weblio = { url = 'http://www.weblio.jp/content/%s' },
        thesaurus = { url = 'http://thesaurus.weblio.jp/content/%s' },
        antonym = { url = 'http://thesaurus.weblio.jp/antonym/content/%s' },
      }
      vim.g['ref_source_webdict_sites.default'] = 'alc'
      -- Define filter functions for webdict sites
      vim.cmd([[
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
      ]])
    end,
    keys = {
      { '<Space>rr', ':<C-u>Ref refe ' },
      { '<Space>rm', ':<C-u>Ref man ' },
      { '<Space>rpy', ':<C-u>Ref pydoc ' },
      { '<Space>rw', ':<C-u>Ref webdict ' },
    },
  },

  { 'bling/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes', 'ompugao/vim-airline-cwd' },
    init = function()
      vim.g.airline_symbols = {
        branch = '⎇',
        linenr = 'L',
        paste = 'ρ',
        whitespace = 'Ξ',
      }
      vim.g.airline_experimental = 1
      vim.g.airline_extensions = { 'branch', 'gina', 'ctrlp', 'quickfix', 'wordcount', 'gutentags', 'cwd', 'nvimlsp' }
      vim.g.airline_theme = 'everforest'
      vim.g.airline_left_sep = ''
      vim.g.airline_right_sep = ''
      vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline#extensions#tabline#ignore_bufadd_pat'] = [[\c\vgundo|undotree|vimfiler|tagbar|nerd_tree]]
      vim.g['airline#extensions#tabline#left_sep'] = ' '
      vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
      vim.g['airline#extensions#branch#enabled'] = 1
      vim.g['airline#extensions#hunks#non_zero_only'] = 1
      vim.g['airline#extensions#disable_rtp_load'] = 0
      vim.g['airline#extensions#cwd#enabled'] = 1
      vim.g['airline#extensions#fugitiveline#enabled'] = 1
      vim.g['airline#extensions#gutentags#enabled'] = 1
      vim.g['airline#extensions#default#section_truncate_width'] = { b = 79, x = 80, y = 88, z = 60 }
      vim.g['airline#extensions#whitespace#enabled'] = 1
      vim.g.airline_mode_map = {
        ['__'] = '-', n = 'N', i = 'I', R = 'R', c = 'C', v = 'v', V = 'V',
        [''] = '^V', s = 's', S = 'S', [''] = '^',
      }
    end,
  },

  { 'img-paste-devs/img-paste.vim',
    ft = { 'markdown', 'patto' },
    init = function()
      vim.g.mdip_imgdir = './assets'
      -- Define PattoPasteImage function
      vim.cmd([[
        function! g:PattoPasteImage(relpath)
          execute "normal! i[@img \"" . g:mdip_tmpname[0:0]
          let ipos = getcurpos()
          execute "normal! a" . g:mdip_tmpname[1:] . "\" " . a:relpath . "]"
          call setpos('.', ipos)
        endfunction
      ]])
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'patto',
        callback = function()
          vim.keymap.set('n', '<leader>P', '<cmd>call mdip#MarkdownClipboardImage()<CR>', { buffer = true })
          vim.g.PasteImageFunction = 'g:PattoPasteImage'
        end,
      })
    end,
  },

  { 'vim-denops/denops.vim' },

  { 'vim-skk/skkeleton',
    dependencies = { 'vim-denops/denops.vim', 'NI57721/skkeleton-henkan-highlight' },
    lazy = false,  -- Load immediately since we need <Plug> mappings available
    init = function()
      vim.o.iminsert = 0
      vim.api.nvim_create_autocmd('User', {
        pattern = 'skkeleton-initialize-pre',
        callback = function()
          vim.fn['skkeleton#config']({
            globalDictionaries = { '~/.skkjisyo/SKK-JISYO.L' },
            keepState = false,
            registerConvertResult = true,
            showCandidatesCount = 1,
            markerHenkan = '',
            markerHenkanSelect = '',
          })
          vim.api.nvim_set_hl(0, 'SkkeletonHenkan', { underline = true })
          vim.api.nvim_set_hl(0, 'SkkeletonHenkanSelect', { underline = true, reverse = true })
        end,
      })
    end,
    config = function()
      -- Set up keymaps after plugin loads so <Plug> mappings exist
      vim.cmd('imap <C-j> <Plug>(skkeleton-enable)')
      vim.cmd('cmap <C-j> <Plug>(skkeleton-enable)')
    end,
  },

  { 'kshenoy/vim-signature' },
  { 'Shougo/vinarise', cmd = 'Vinarize' },
  { 'scrooloose/nerdcommenter' },
  { 'mattn/webapi-vim', lazy = true },

  { 'tyru/open-browser.vim',
    keys = {
      { '<space>ob', '<Plug>(openbrowser-open)', mode = { 'n', 'x' } },
      { '<space>ow', '<Plug>(openbrowser-search)' },
      { '<space>os', '<Plug>(openbrowser-smart-search)', mode = { 'n', 'x' } },
    },
  },

  { 'mopp/autodirmake.vim' },
  { 'mattn/emmet-vim', ft = { 'html', 'css', 'jsx', 'tsx' } },
  { 'ivalkeen/vim-ctrlp-tjump', dependencies = { 'ctrlpvim/ctrlp.vim' } },
  { 'mattn/vim-molder', init = function() vim.g.molder_show_hidden = 1 end },
  { 'mattn/vim-molder-operations', dependencies = { 'mattn/vim-molder' } },
  { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' },

  { 'ludovicchabant/vim-gutentags',
    init = function()
      vim.g.gutentags_cache_dir = vim.fn.expand('~') .. '/.gutentags'
      vim.g.gutentags_ctags_extra_args = { '--excmd=number' }
      if vim.fn.isdirectory(vim.g.gutentags_cache_dir) == 0 then
        vim.fn.mkdir(vim.g.gutentags_cache_dir, 'p')
      end
    end,
  },

  { 'rhysd/vim-clang-format',
    ft = { 'c', 'cpp', 'objc' },
    init = function()
      vim.g['clang_format#style_options'] = {
        AccessModifierOffset = -2,
        AllowShortIfStatementsOnASingleLine = "false",
        AllowShortBlocksOnASingleLine = "false",
        AllowShortCaseLabelsOnASingleLine = "false",
        AllowShortFunctionsOnASingleLine = "Empty",
        ColumnLimit = "120",
        SortIncludes = "false",
        AlwaysBreakTemplateDeclarations = "true",
        UseTab = "Never",
        DerivePointerAlignment = "false",
        PointerAlignment = "Left",
        Standard = "C++11",
      }
    end,
  },

  { 'mhinz/vim-grepper',
    cmd = 'Grepper',
    init = function()
      vim.g.grepper = {
        stop = 10000,
        rg = { grepprg = 'rg -H --no-heading --vimgrep --smart-case -g "!tags"' },
      }
    end,
    keys = {
      { '<Space>gg', ':<C-u>Grepper -tool git<CR>' },
      { '<Space>gi', ':<C-u>Grepper -tool rg<CR>' },
      { '<Space>g*', ':<C-u>Grepper -tool rg -cword -noprompt<CR>' },
    },
  },

  { 'ompugao/quickdict.vim',
    keys = {
      { '<Space>rq', ':<C-u>QuickDictEcho <C-r><C-w><CR>' },
      { '<Space>ra', ':<C-u>QuickDictAppend <C-r><C-w><CR>' },
      { '<Space>rA', ':<C-u>QuickDictInsertLast <C-r><C-w><CR>' },
    },
  },

  { 'preservim/tagbar', cmd = 'TagbarToggle' },
  { 'stefandtw/quickfix-reflector.vim' },
})

-- Editor Settings
local opt = vim.opt

opt.autoindent = true
opt.backup = true
opt.backupdir = vim.fn.expand('~/.nvimbackup')
opt.directory = vim.fn.expand('~/.nvimswap')
opt.diffopt:append('vertical')

for _, dir in ipairs({ vim.o.backupdir, vim.o.directory }) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

vim.api.nvim_create_autocmd('SwapExists', {
  callback = function() vim.v.swapchoice = 'o' end,
})

if vim.fn.has('persistent_undo') == 1 then
  opt.undodir = vim.fn.expand('~/.nvimundo')
  if vim.fn.isdirectory(vim.o.undodir) == 0 then
    vim.fn.mkdir(vim.o.undodir, 'p')
  end
  opt.undofile = true
end

opt.list = true
opt.listchars = { tab = '>-', trail = '_', nbsp = '%' }
opt.scrolloff = 4
opt.ignorecase = true
opt.smartcase = true
opt.showcmd = true
opt.laststatus = 2
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.expandtab = false
opt.incsearch = true
opt.hlsearch = true
opt.wrap = true
opt.breakindent = true
opt.breakindentopt = 'min:50,shift:4,sbr'
opt.showbreak = '↪'
opt.display = 'lastline'
opt.showtabline = 2
opt.switchbuf = 'useopen'
opt.infercase = true
opt.hidden = true
opt.visualbell = true
opt.virtualedit:append('block')
opt.nrformats:append('unsigned')
opt.clipboard = 'unnamedplus'
opt.wildmode = 'longest:full,full'
opt.wildmenu = true
opt.wildoptions = 'pum'
opt.showmatch = true
opt.matchtime = 1
opt.matchpairs:append('<:>')
opt.backspace = 'indent,eol,start'
opt.history = 10000
opt.foldenable = true
opt.foldmethod = 'marker'
opt.shortmess:remove('S')
opt.shellslash = true
opt.isfname:append('@-@')
opt.isfname:remove('=')
opt.grepprg = 'grep -nH $*'
opt.completeopt = 'menuone,noinsert,noselect'
opt.pumheight = 12
opt.termguicolors = true
opt.background = 'dark'

vim.g.tex_conceal = ""
if vim.fn.has('conceal') == 1 then
  opt.conceallevel = 2
  opt.concealcursor = 'c'
end

vim.g.markdown_fenced_languages = { 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml' }
vim.g.netrw_liststyle = 3
vim.g.lisp_rainbow = 1

-- Colorscheme
vim.cmd('colorscheme everforest')
vim.api.nvim_set_hl(0, 'MatchParen', { ctermbg = 'LightGrey', ctermfg = 'lightcyan', bg = 'LightGrey', fg = 'lightcyan' })
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'none' })

-- Autocommands
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'h', 'cpp', 'cuda', 'vim' },
  callback = function() vim.opt_local.expandtab = true end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.l',
  callback = function() vim.bo.filetype = 'lisp' end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lisp',
  callback = function() vim.opt_local.commentstring = ';%s' end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'ruby' },
  callback = function() vim.opt_local.commentstring = ' #%s' end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'launch' },
  callback = function() vim.opt_local.commentstring = ' <!-- %s -->' end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.launch',
  callback = function()
    vim.bo.filetype = 'launch'
    vim.bo.syntax = 'xml'
  end,
})

-- Auto cursorline
local cursorline_lock = 0
local function auto_cursorline(event)
  if event == 'WinEnter' then
    vim.wo.cursorline = true
    cursorline_lock = 2
  elseif event == 'WinLeave' then
    vim.wo.cursorline = false
  elseif event == 'CursorMoved' then
    if cursorline_lock > 0 then
      if cursorline_lock > 1 then
        cursorline_lock = 1
      else
        vim.wo.cursorline = false
        cursorline_lock = 0
      end
    end
  elseif event == 'CursorHold' then
    vim.wo.cursorline = true
    cursorline_lock = 1
  end
end

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = function() auto_cursorline('CursorMoved') end,
})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function() auto_cursorline('CursorHold') end,
})
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function() auto_cursorline('WinEnter') end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  callback = function() auto_cursorline('WinLeave') end,
})

-- TODO highlighting
vim.api.nvim_create_autocmd('Syntax', {
  callback = function()
    vim.fn.matchadd('Todo', [[\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)]])
  end,
})

-- Disable syntax for large files
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.fn.getfsize(vim.fn.expand('%')) > 1000000 then
      vim.cmd('setlocal syntax=OFF')
    end
  end,
})

-- TeX auto-replace
vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*.tex',
  callback = function()
    vim.cmd([[silent! %s/、/, /g]])
    vim.cmd([[silent! %s/。/. /g]])
  end,
})

-- cmake dictionary
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cmake',
  callback = function()
    local cmake_dict = vim.fn.stdpath('config') .. '/dict/cmake.txt'
    if vim.fn.filereadable(cmake_dict) == 1 then
      vim.opt_local.dictionary:append(cmake_dict)
    end
  end,
})

-- fzf statusline
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fzf',
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.showmode = false
    vim.opt_local.ruler = false
    vim.api.nvim_create_autocmd('BufLeave', {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = 2
        vim.opt.showmode = true
        vim.opt.ruler = true
      end,
    })
  end,
})

-- Keymaps
local keymap = vim.keymap.set

keymap('n', '<Space>d', ':<C-u>bd<CR>')
keymap('n', '<Space><Space>', 'i<Space><Esc>la<Space><Esc>')
keymap({ 'n', 'v' }, ';', ':')
keymap({ 'n', 'v' }, ':', ';')
keymap('n', '<C-]>', 'g<C-]>')
keymap('c', '<C-p>', '<Up>')
keymap('c', '<C-n>', '<Down>')
keymap('c', '<C-X>', function()
  local path = vim.fn.expand('%:p:h')
  return path .. (vim.o.shellslash and '/' or '\\')
end, { expr = true })
keymap('c', '<C-T>', function() return os.date('%Y-%m-%d') end, { expr = true })
vim.cmd('cabbr w!! w !sudo tee > /dev/null %')
keymap('n', '<Leader>y', 'my:0,$!xsel -iob<CR>u`y')

-- Force blockwise visual
local function force_blockwise_visual(next_key)
  local mode = vim.fn.mode()
  if mode == 'v' then
    return '<C-v>' .. next_key
  elseif mode == 'V' then
    return '<C-v>0o$' .. next_key
  else
    return next_key
  end
end
keymap('x', 'I', function() return force_blockwise_visual('I') end, { expr = true })
keymap('x', 'A', function() return force_blockwise_visual('A') end, { expr = true })

-- Toggle terminal
local function term_list()
  local bufs = vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })
  local res = {}
  for _, item in ipairs(bufs) do
    if item.variables and item.variables.terminal_job_id then
      table.insert(res, item.bufnr)
    end
  end
  return res
end

local function toggle_terminal()
  local terms = term_list()
  if #terms == 0 then
    vim.cmd('split')
    vim.cmd('wincmd J')
    vim.cmd('resize 10')
    vim.wo.winfixheight = true
    vim.cmd('terminal')
    vim.cmd('startinsert')
  else
    local wins = vim.fn.win_findbuf(terms[1])
    if #wins == 0 then
      vim.cmd('botright 10split')
      vim.wo.winfixheight = true
      vim.cmd('buffer ' .. terms[1])
      vim.cmd('startinsert')
    else
      vim.api.nvim_win_hide(wins[1])
    end
  end
  vim.bo.buflisted = false
end

keymap('i', '<F2>', toggle_terminal)
keymap('n', '<F2>', toggle_terminal)
keymap('t', '<F2>', toggle_terminal)

-- OSC52 clipboard
local function osc52_supported()
  local term = vim.env.TERM or ""
  local tty = vim.env.SSH_TTY or vim.fn.getenv("TTY") or ""
  if vim.env.NVIM_TERM == "alacritty" or vim.env.TERM_PROGRAM == "WezTerm" then
    return true
  end
  if tty ~= "" then
    return true
  end
  if term:match("xterm") or term:match("tmux") then
    return true
  end
  return false
end
if osc52_supported() then
  vim.o.clipboard = "unnamedplus"
  -- vim.g.clipboard = "osc52"
  -- OSC52 only supports copy (write to system clipboard), not paste (read)
  -- For paste, we rely on terminal's native paste or bracketed paste mode
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      -- Return nil to use Neovim's default paste behavior
      -- This avoids interfering with insert mode and skkeleton
      ["+"] = function() return nil end,
      ["*"] = function() return nil end,
    },
  }
end

-- extui (if available)
local ok, extui = pcall(require, 'vim._extui')
if ok then
  extui.enable({
    enable = true,
    msg = { target = 'cmd', timeout = 3000 },
  })
end

--vim.cmd('filetype plugin indent on')
