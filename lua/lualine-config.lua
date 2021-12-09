require('lualine').setup {
  options = {
    theme = Settings.settings.lualine_colorscheme,
    -- section_separators = {left = '', right = ''},
    -- component_separators = {left = '', right = ''}
  },
  extensions = {'nvim-tree', 'toggleterm'}
}
