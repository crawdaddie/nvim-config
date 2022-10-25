local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

local packer = Settings.utils.plugins.require('packer')

packer.init(Settings.plugins.packer.init)

local function is_enabled(plugin)
  return Settings.plugins[plugin].enabled
end

local function get_cmp()
  if Settings.plugins.cmp.enabled == true then
    return 'nvim-cmp'
  else
    return
  end
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Syntax Highlighting and Visual Plugins
  use { 'norcalli/nvim-colorizer.lua', disable = not is_enabled('colorizer'), config = "require'colorizer-config'", event = 'BufRead' }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = 'require"bufferline-config"',
    disable = true,
    event = 'BufWinEnter'
  }
  use { 'hoob3rt/lualine.nvim', disable = not is_enabled('lualine'), config = "require'lualine-config'", event = 'BufWinEnter' }
  use { 'glepnir/dashboard-nvim', disable = not is_enabled('dashboard'), config = "require'dashboard-config'", event = 'BufWinEnter' }

  -- Tree-Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufWinEnter',
    run = ':TSUpdate',
    disable = not is_enabled('treesitter'),
    config = "require'treesitter-config'"
  }
  use { 'p00f/nvim-ts-rainbow', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }
  use { 'windwp/nvim-ts-autotag', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }

  -- Colorschemes
  use { "junegunn/seoul256.vim", config = "require'colorscheme.seoul256-light'" }
  -- Icons
  use { "kyazdani42/nvim-web-devicons" }


  -- LSP
  use { 'neovim/nvim-lspconfig', event = "BufRead" }
  use {
    -- "glepnir/lspsaga.nvim",
    "al3xfischer/lspsaga.nvim",
    -- config = "require'lspsaga-config'",
    event = "BufRead"
  }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'onsails/lspkind-nvim' }

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter *",
    config = function()
      require 'cmp-config'
    end,
    disable = not is_enabled('cmp')
  }

  use { "/Users/adam/projects/friendly-snippets", after = "nvim-cmp", event = "InsertEnter" }
  use { 'hrsh7th/cmp-nvim-lsp', disable = not is_enabled('cmp') }
  use { 'hrsh7th/cmp-buffer', after = "nvim-cmp", disable = not is_enabled('cmp') }
  use { 'hrsh7th/cmp-cmdline', after = "nvim-cmp", disable = not is_enabled('cmp') }
  use { 'hrsh7th/cmp-path', after = "nvim-cmp", disable = not is_enabled('cmp') }

  -- use {'hrsh7th/cmp-vsnip', disable = not is_enabled('cmp'), after = "nvim-cmp"}

  use {
    'hrsh7th/cmp-vsnip',
    after = 'nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      {
        'rafamadriz/friendly-snippets',
        after = 'cmp-vsnip',
      }
    }
  }

  use { 'windwp/nvim-autopairs', after = get_cmp(), config = "require'autopairs-config'", disable = not is_enabled('autopairs') }

  -- Version Control
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, disable = not is_enabled('gitsigns') }

  -- Terminal Integration
  use { 'akinsho/nvim-toggleterm.lua', disable = not is_enabled('toggleterm'), config = 'require"toggleterm-config"' }

  -- Navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    cmd = "Telescope",
    disable = not is_enabled('telescope'),
    config = "require'telescope-config'",
  }
  use { 'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle", disable = not is_enabled('nvim_tree'), config = "require'nvimtree-config'" }
  use { "nvim-telescope/telescope-file-browser.nvim" }

  -- Other
  use { 'terrortylor/nvim-comment', cmd = "CommentToggle", config = "require('nvim_comment').setup()", disable = not is_enabled('nvim_comment') }
  use { 'folke/which-key.nvim', event = "BufWinEnter" }


  use {
    'rottencandy/vimkubectl'
  }

  for _, plugin in pairs(Settings.plugins.user) do use(plugin) end
end)
