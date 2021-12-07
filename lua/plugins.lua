local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"


if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " ..
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


    -- completion
    -- use {"hrsh7th/cmp-nvim-lsp"}
    -- use {"hrsh7th/vim-vsnip"}
    -- use {"hrsh7th/cmp-vsnip" }
    -- use { "hrsh7th/cmp-buffer"}
    -- use {"hrsh7th/cmp-cmdline"}
    -- use { "/Users/adam/projects/friendly-snippets", event = "InsertEnter" }
    -- use {"hrsh7th/nvim-cmp"}
    

    -- explorer
    use {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree-config").config()
        end,
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
    use { 'f-person/git-blame.nvim' }
    use { 'iamcco/markdown-preview.nvim' }
    use {
	    "luukvbaal/stabilize.nvim",
	    config = function() require("stabilize").setup() end
    }
    -- db 
    -- use {
    --     'tpope/vim-dadbod'
    -- }
    -- use { 'kristijanhusak/vim-dadbod-ui' }
    use { 'mhinz/vim-startify' }
end)

