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
  -- use {'rose-pine/neovim', as = 'rose-pine', opt = true}
  -- use {'joshdick/onedark.vim', opt = true}
  -- use {'gruvbox-community/gruvbox', opt = true}
  -- use {'shaunsingh/nord.nvim', opt = true}
  -- use {'folke/tokyonight.nvim', opt = true}
  -- use {'dracula/vim', as = 'dracula', opt = true}
  -- use {'tiagovla/tokyodark.nvim', opt = true}
  -- themes
  -- use { "projekt0n/github-nvim-theme" }
  use { "junegunn/seoul256.vim", config = "require'colorscheme.seoul256-light'" }
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }
  -- use {"glepnir/galaxyline.nvim"}


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
    config = "require'telescope-config'"
  }
  use { 'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle", disable = not is_enabled('nvim_tree'), config = "require'nvimtree-config'" }
  use { "nvim-telescope/telescope-file-browser.nvim" }

  -- Other
  use { 'terrortylor/nvim-comment', cmd = "CommentToggle", config = "require('nvim_comment').setup()", disable = not is_enabled('nvim_comment') }
  -- use {'lukas-reineke/format.nvim', disable = not is_enabled('format'), config = "require'formatting'"}
  use { 'folke/which-key.nvim', event = "BufWinEnter" }
  use { '/Users/adam/projects/sc/scnvim' }
  -- use { 'madskjeldgaard/supercollider-h4x-nvim',
  --   config = function()
  --     require 'supercollider-h4x'.setup()
  --   end,
  --   after = { 'scnvim' },
  --   requires = {
  --     '/Users/adam/projects/sc/scnvim'
  --     -- 'davidgranstrom/scnvim'
  --   }
  -- }
  -- use {
  --   'madskjeldgaard/fzf-sc',
  --   config = function()
  --     require 'fzf-sc'.setup({ search_plugin = "nvim-fzf", })
  --   end,
  --   requires = {
  --     'vijaymarupudi/nvim-fzf',
  --     '/Users/adam/projects/sc/scnvim'
  --   }
  -- }

  use {
    'rottencandy/vimkubectl'
  }

  -- jupyter
  -- use { '/Users/adam/projects/magma-nvim',
  --   config = "require'nvim-magma-config'",
  --   -- disable = not is_enabled('magmanvim'),
  -- run = ':UpdateRemotePlugins'
  -- }
  -- use { 'jupyter-vim/jupyter-vim' }
  -- use { 'jpalardy/vim-slime', config = "require'vim-slime-config'" }
  -- use { 'hanschen/vim-ipython-cell', config = "require'ipython-cell-config'" }

  for _, plugin in pairs(Settings.plugins.user) do use(plugin) end
end)
