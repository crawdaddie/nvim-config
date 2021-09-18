local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"


if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wpthomason/acker.nvim " ..
		install_path)
	execute "packadd packer.nvim"
end
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

    -- lsp requires
    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim", event = "BufRead"}
    use {"kabouzeid/nvim-lspinstall", event = "BufRead"}

	-- Telescope
	use { "nvim-lua/popup.nvim" }
	use { "nvim-telescope/telescope.nvim", requires = { {'nvim-lua/plenary.nvim'} } }

    -- Autocomplete
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("compe-config").config()
        end
    }

    use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
    use {"rafamadriz/friendly-snippets", event = "InsertEnter"}
    --
    -- explorer
    use {
        "kyazdani42/nvim-tree.lua",
        -- cmd = "NvimTreeToggle",
        config = function()
            require("nvim-tree-config").config()
        end,
        -- after = "barbar.nvim",
    }


    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}


    -- LSP Colors
    use {
        "folke/lsp-colors.nvim",
        event = "BufRead",
    }

    -- themes
    use { "projekt0n/github-nvim-theme" }
    use { "junegunn/seoul256.vim" }
    -- Icons
    use {"kyazdani42/nvim-web-devicons"}
    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}

    -- Comments
    use {
        "terrortylor/nvim-comment",
        cmd = "CommentToggle",
        config = function()
            require('nvim_comment').setup()
        end
    }
    use { "rottencandy/vimkubectl" }
    use { '/Users/adam/projects/sc/scnvim' }
    use { 'tpope/vim-fugitive' }

    use { 'iamcco/markdown-preview.nvim' }
end)

