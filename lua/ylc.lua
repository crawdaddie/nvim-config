local lspconfig = require('lspconfig')
local configs = require 'lspconfig.configs'

-- if not configs.ylc_lsp then
--   configs.ylc_lsp = {
--     default_config = {
--       cmd = { 'ylc-lsp-server' },
--       root_dir = lspconfig.util.root_pattern('.git'),
--       filetypes = { 'ylc' },
--     },
--   }
-- end
-- lspconfig.ylc_lsp.setup {}

vim.cmd([[
  autocmd BufRead,BufNewFile *.ylc set filetype=ylc
]])
