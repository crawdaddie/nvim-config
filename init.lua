require('settings')
require('vim-options')
require('plugins')
require('keybindings')

-- Syntax and Visual
-- If a custom theme is wanted, require() that in user-config.init
-- Otherwise if the default theme is not wanted change Vapour.settings.colorscheme
-- This will return nil if it's not found
if Settings.settings.colorscheme ~= "custom" then Settings.utils.plugins.require('colorscheme.' .. Settings.settings.colorscheme) end

-- LSP and Autocomplete
require('lsp')
-- Git
require('gitsigns-config')

-- Other
require('which-key-config')
if Settings.settings.transparent_bg then vim.cmd('hi Normal guibg=NONE ctermbg=NONE') end
vim.cmd('highlight clear LineNr')
require('scnvim-config')
require('autocmd')
