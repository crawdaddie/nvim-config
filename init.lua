require('default-config')
require('settings')
require('plugins')
require('colorscheme')
require('keymappings')
require('autocommands')
require('telescope-config')
require('galaxyline-config')
require('treesitter-config')

require('lsp')
-- TODO should I put this in the filetype files?
if O.lang.sh.active then require('lsp.bash-ls') end
if O.lang.css.active then require('lsp.css-ls') end
if O.lang.docker.active then require('lsp.docker-ls') end
if O.lang.efm.active then require('lsp.efm-general-ls') end
if O.lang.graphql.active then require('lsp.graphql-ls') end
if O.lang.html.active then require('lsp.html-ls') end
if O.lang.json.active then require('lsp.json-ls') end
require('lsp.lua-ls')
if O.lang.python.active then require('lsp.python-ls') end
if O.lang.rust.active then
    require('lsp.rust-ls')
    require('lv-rust-tools')
end
if O.lang.terraform.active then require('lsp.terraform-ls') end
if O.lang.tailwindcss.active then require('lsp.tailwindcss-ls') end
if O.lang.vim.active then require('lsp.vim-ls') end
if O.lang.yaml.active then require('lsp.yaml-ls') end
require('lsp.js-ts-ls')
