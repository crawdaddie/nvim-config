-- npm i -g pyright
-- local util = require'nvim_lsp
local util = require 'lspconfig/util'
require'lspconfig'.pyright.setup {
    cmd = {DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio"},
    filetypes = { "python" },
    -- on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.lang.python.diagnostics.virtual_text,
            signs = O.lang.python.diagnostics.signs,
            underline = O.lang.python.diagnostics.underline,
            update_in_insert = false 
        })
    },
    root_dir = function(fname)
          local root_files = {
            'pyproject.toml',
            'setup.py',
            'pyvenv.cfg',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json',
          }
          return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
        end,
    settings = {
      python = {
        analysis = {
		  typeCheckingMode = O.lang.python.analysis.type_checking,
		  autoSearchPaths = O.lang.python.analysis.auto_search_paths,
          useLibraryCodeForTypes = O.lang.python.analysis.use_library_code_types
        }
      }
    }
}
