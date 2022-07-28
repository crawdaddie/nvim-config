local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
-- local telescope = require('telescope')
-- local pickers = require 'telescope.pickers'
-- local pickers = require((...) .. '.scnvim-telescope')


scnvim.setup {
  keymaps = {
    ['<M-a>'] = map('editor.send_line', { 'i', 'n' }),
    ['<C-a>'] = {
      map('editor.send_block', { 'i', 'n' }),
      map('editor.send_selection', 'x'),
    },
    ['<CR>'] = map('postwin.toggle'),
    ['<M-CR>'] = map('postwin.toggle', 'i'),
    ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),
    ['<C-g>'] = map('signature.show', { 'n', 'i' }),
    ['<leader>sx'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
    ['<leader>sb'] = map('sclang.start'),
    ['<leader>sr'] = map('sclang.recompile'),
    ['<F1>'] = map_expr('s.boot'),
    ['<F2>'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
      color = 'TermCursor',
      type = 'flash',
    },
    signature = {
      float = true,
      auto = true,
    }
  },
  postwin = {
    highlight = true,
    float = {
      enabled = true,
    },
    width = 64,
    height = 32,
    config = {
      border = 'single',
    },
  },
  documentation = {
    float = true,
    cmd = 'pandoc',
  }
  -- snippet = {
  --   engine = {
  --     name = "vim-vsnip"
  --   }
  -- }
}
-- vim.g.scnvim_postwin_orientation = "h"
-- vim.g.scnvim_postwin_size = 15
-- vim.g.scnvim_scdoc = 1
-- vim.g.scnvim_snippet_format = "vim-vsnip"

-- vim.g.scnvim_sclang_executable = "~/projects/sc/sclang-lsp-stdio/sclang-lsp-stdio.mjs"
