Settings.utils.plugins.packadd('nvim-treesitter')

require'nvim-treesitter.configs'.setup {
  ensure_installed = Settings.plugins.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = Settings.plugins.treesitter.ignore_install,
  indent = Settings.plugins.treesitter.indent,
  highlight = Settings.plugins.treesitter.highlight,
  autotag = Settings.plugins.treesitter.autotag,
  rainbow = Settings.plugins.treesitter.rainbow
}
