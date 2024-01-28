-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  -- {
  --   'filipdutescu/renamer.nvim',
  --   branch = 'master',
  --   dependencies = { 'nvim-lua/plenary.nvim' }
  -- },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    }
  },
  { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',     opts = {} },
  -- {
  --   -- Adds git releated signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },
  {
    'crawdaddie/seoul256.vim',
    dir = "~/.config/seoul256.vim"
  },
  -- { 'mswift42/vim-themes' },
  -- { 'junegunn/seoul256.vim' },
  -- { "rose-pine/neovim", name = "rose-pine" },
  -- { "bohrshaw/vim-colors" },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
        -- component_separators = { left = "", right = "" },
        -- section_separators = '',
        -- section_separators = { left = '', right = '' },
        globalstatus = true,
      },
    },
  },


  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        ---Line-comment toggle keymap
        line = ' /',
        ---Block-comment toggle keymap
        block = ' \\',
      },
      opleader = {
        ---Line-comment toggle keymap
        line = ' /',
        ---Block-comment toggle keymap
        block = ' \\',
      }
    }
  },
  'norcalli/nvim-colorizer.lua',


  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',          version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  -- },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lu`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',

  -- {
  --   'davidgranstrom/scnvim',
  --   config = function()
  --     require('scnvim-config')
  --   end
  -- },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
      require('slime')
      vim.api.nvim_create_user_command("OcamlRepl", OpenOcamlRepl, {})
      vim.api.nvim_create_user_command("PythonRepl", OpenPythonRepl, {})
      vim.api.nvim_create_user_command("SicpRepl", OpenSicpRepl, {})
    end,
  },



}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require('telescope.actions')

require('telescope').setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader> ', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sf', function()
  -- You can pass additional bonfiguration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'vimdoc', 'vim' },
  ignore_install = {},
  modules = {},
  sync_install = false,

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set('n', '<leader>q', require('telescope.builtin').quickfix, { desc = "Open Quickfix" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- local rename = require('renamer').rename

  nmap('<leader>r', vim.lsp.buf.rename, '[R]e[n]ame')
  -- nmap('<leader>rn', rename, '[R]e[n]ame')
  nmap('<leader>sa', vim.lsp.buf.code_action, '[C]ode [A]ction')
  -- nmap('<leader>cb', require('ui').input, '[C]ode [A]ction')


  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('H', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- " hi LspDiagnosticsDefaultError gui=italic guifg=#ef7872
  -- " hi LspDiagnosticsDefaultWarning gui=italic guifg=#f4a46e
  -- " hi LspDiagnosticsDefaultHint gui=italic guifg=#6a6765
  -- " hi LspDiagnosticsDefaultInformation gui=italic guifg=#6a6765
  -- " hi link LspDiagnosticsDefaultHint DiagnosticHint
  -- " hi link LspDiagnosticsDefaultInformation DiagnosticInfo
  -- " hi! link DiagnosticHint #6a6765
  -- " hi! link DiagnosticInfo #6a6765
  --
  -- highlight DiagnosticError guifg=#0000ff
  -- highlight DiagnosticWarn guifg=#0000ff
  -- highlight DiagnosticInfo guifg=#0000ff
  -- highlight DiagnosticHint guifg=#0000ff
  vim.api.nvim_exec2([[

  highlight DiagnosticHint guifg=#0000ff

  ]], { output = false })
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec2([[
    hi LspDiagnosticsDefaultError gui=italic guifg=#ef7872
    hi LspDiagnosticsDefaultWarning gui=italic guifg=#f4a46e
    hi LspDiagnosticsDefaultHint gui=italic guifg=#6a6765
    hi LspDiagnosticsDefaultInformation gui=italic guifg=#6a6765
    hi link LspDiagnosticsDefaultHint DiagnosticHint
    hi link LspDiagnosticsDefaultInformation DiagnosticInfo
    hi! link DiagnosticHint #6a6765
    hi! link DiagnosticInfo #6a6765


    hi LspReferenceRead cterm=bold ctermbg=red guibg=#d9d8d3
    hi LspReferenceText cterm=bold ctermbg=red guibg=#d9d8d3
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=#d9d8d3

    augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END]],
      { output = false }
    )
  end
end
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable=false})]]

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" }
    }
  },
  -- tsserver = {},
  ocamllsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  pylsp = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = false },
        ruff = { enabled = true },
        -- executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
        rope_autoimport = { enabled = true },
      },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local Border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
local cmds = {
  ocaml_lsp = 'ocamllsp'
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          signs = true,
          underline = true,
          -- update_in_insert = true fucks up text as I'm typing - don't like it
          update_in_insert = false,
        }),
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = Border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = Border }),
      }
    }
    if cmds[server_name] then
      require('lspconfig')[server_name].cmd = { cmds[server_name] }
    end
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load {}
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

cmp.setup.cmdline('/', {
  -- mapping = cmp.mapping.preset.insert {
  --   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete {},
  --   ['<CR>'] = cmp.mapping.confirm {
  --     behavior = cmp.ConfirmBehavior.Replace,
  --     select = true,
  --   },
  --   ['<Tab>'] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_next_item()
  --     elseif luasnip.expand_or_jumpable() then
  --       luasnip.expand_or_jump()
  --     else
  --       fallback()
  --     end
  --   end, { 'i', 's' }),
  --   ['<S-Tab>'] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_prev_item()
  --     elseif luasnip.jumpable(-1) then
  --       luasnip.jump(-1)
  --     else
  --       fallback()
  --     end
  --   end, { 'i', 's' }),
  -- },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'fuzzy_buffer' }
  })
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- require('colorscheme')
require("options")

vim.api.nvim_exec2([[
  autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  set title
]], {})

local fe_callback = function()
  vim.bo.filetype = "fe"    -- set filetype
  vim.bo.syntax = "clojure" -- set syntax
  -- vim.bo.commentstring = "'%s" -- set comment string
  -- vim.bo.ts = 4                -- set tapspaces 4
  -- vim.bo.sw = 4                -- set shiftwidth 4
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePost", "BufRead" }, {
  pattern = "*.fe",
  callback = fe_callback,
})

require 'colorscheme'
require 'CurtineIncSw'
require 'nvimtree-config'

vim.cmd([[
  autocmd BufRead,BufNewFile *.ylc set filetype=ylc
]])
require 'keybindings'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
