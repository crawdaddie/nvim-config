require('default-config')
require('settings')
require('plugins')
require('colorscheme')
require('keymappings')
require('autocommands')
require('telescope-config')
require('galaxyline-config')
require('treesitter-config')
require('scnvim-config')
require('vim-vsnip-config')

require('lsp')
require('lsp.bash-ls')
-- if O.lang.css.active then require('lsp.css-ls') end
require('lsp.docker-ls')
-- if O.lang.graphql.active then require('lsp.graphql-ls') end
-- if O.lang.html.active then require('lsp.html-ls') end
-- if O.lang.json.active then require('lsp.json-ls') end
-- require('lsp.lua-ls')
require('lsp.python-ls')
-- require('lsp.rust-ls')
-- if O.lang.terraform.active then require('lsp.terraform-ls') end
-- if O.lang.tailwindcss.active then require('lsp.tailwindcss-ls') end
-- if O.lang.vim.active then require('lsp.vim-ls') end
-- if O.lang.yaml.active then 
require('lsp.yaml-ls')
require('lsp.efm-general-ls')
require('lsp.js-ts-ls')
