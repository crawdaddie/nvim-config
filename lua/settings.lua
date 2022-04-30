require('globals')

Settings = {}

-- Settings object to use for namespacing
Settings = {
  options = {tabwidth = 2},
  language_servers = {
    sumneko_lua = {enabled = true},
    bashls = {enabled = true},
    cssls = {enabled = true},
    html = {enabled = true},
    -- tsserver = {
    --   enabled = false 
    -- },
    pyright = {enabled = false},
    jedi_language_server = {enabled = true},
    pylsp = {enabled = false},
    vimls = {enabled = true},
    yamlls = {enabled = true},
    solargraph = {enabled = false},
    vuels = {enabled = false},
    
    jsonls = {
      enabled = true,
      setup = {
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
          }
        }
      }
    },
    gopls = {enabled = true, setup = {cmd = {"gopls", "serve"}, settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}}}
  },
  plugins = {
    colorizer = {enabled = true},
    autopairs = {enabled = true},
    gitsigns = {enabled = true},
    bufferline = {enabled = false},
    lualine = {enabled = true},
    dashboard = {enabled = true},
    lspsaga = {enabled = true},
    toggleterm = {
      enabled = true,
      toggle_float = function()
        local Terminal = require('toggleterm.terminal').Terminal
        local float = Terminal:new({direction = "float"})
        return float:toggle()
      end,
      toggle_lazygit = function()
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
        return lazygit:toggle()
      end,
      which_key = {
        root = "T",
        name = "Terminal",
        definitions = {
          t = {":ToggleTerm<cr>", "Split Below"},
          f = {"<cmd>lua Settings.plugins.toggleterm.toggle_float()<cr>", "Floating Terminal"},
          l = {"<cmd>lua Settings.plugins.toggleterm.toggle_lazygit()<cr>", "LazyGit"}
        }
      }
    },
    treesitter = {
      enabled = true,
      ensure_installed = "all",
      ignore_install = {"haskell", "php", "phpdoc", "supercollider" },
      indent = {enable = true, disable = { "supercollider" }},
      highlight = {enable = true, disable = { "supercollider" }},
      autotag = {enable = true, disable = { "supercollider" }},
      rainbow = {enable = true, extended_mode = false, disable = {"html", "supercollider"}}
    },
    vsnip = {enabled = true},
    telescope = {enabled = true},
    nvim_tree = {enabled = true},
    dial = {enabled = true},
    format = {enabled = false},
    nvim_comment = {enabled = true},
    cmp = {
      enabled = true,
      sources = {
        {name = 'nvim_lsp'},
        {name = 'vsnip'},
        {name = 'buffer'},
        {name = 'omni'},
        -- {name = "dictionary", keyword_length = 2}
      }
    },
    which_key = {user_defined = {}},

    -- Packer-specific needs
    packer = {
      enabled = true,
      -- See Settings/user-config/README.md for an example use of this
      init = {
        display = {
          open_fn = function()
            return Settings.utils.plugins.require('packer.util').float {border = "single"}
          end
        }
      }
    },

    -- User-loaded plugins
    user = {}
  },

  -- To update see Settings.utils
  utils = {},

  settings = {
    -- If true, :w -> :w!
    always_force_write = true,
    colorscheme = 'seoul256-light',
    lualine_colorscheme = 'auto',
    transparent_bg = false
  }
}

require('utils')
