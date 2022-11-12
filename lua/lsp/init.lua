Settings.utils.plugins.packadd('nvim-lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = Settings.utils.plugins.require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspUtils = require((...) .. '.utils')

vim.o.updatetime = 250
local Border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable=false})]]



-- Language servers
local opts = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    lspUtils.documentHighlight(client, bufnr)
    lspUtils.documentAutoFormat(client, bufnr)
  end,
  root_dir = function(_)
    return vim.loop.cwd()
  end,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = true,
      -- update_in_insert = true fucks up text as I'm typing - don't like it
      update_in_insert = false,
    }),
  }
}

lsp_installer.on_server_ready(function(server)
  local config = Settings.language_servers[server] or { enabled = true }
  if config.enabled == true then
    if config.Settings_init then config.Settings_init(capabilities) end
    local setup_opts = config.setup or opts
    server:setup(setup_opts)
  end
end)


lspconfig['tsserver'].setup({
  cmd = { DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = function(client, bufnr)
    lspUtils.documentHighlight(client, bufnr)
  end,
  root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  handlers = opts.handlers
})

lspconfig['ccls'].setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative"
    }
  },
  cmd = { "/usr/bin/ccls" },
  capabilities = capabilities,
  filetypes = { "c", "cpp" },
  root_dir = require('lspconfig/util').root_pattern(".ccls", ".git"),
  handlers = opts.handlers
})


require 'lspconfig'.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  }
}

require 'lspconfig'.gopls.setup { cmd = { "gopls", "serve" }, settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } } }

-- Lua is a little bit different

USER = vim.fn.expand('$USER')
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- symbols for autocomplete
require('vim.lsp.protocol').CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}


vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = { spacing = 5, severity_limit = 'Warning' },
  update_in_insert = false
})
