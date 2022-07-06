Settings.utils.plugins.packadd('nvim-lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = Settings.utils.plugins.require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require((...) .. '.sc')
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



-- local saga = require 'lspsaga'
-- saga.init_lsp_saga({
-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = false,
--   sign_priority = 20,
--   virtual_text = false,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}
-- })

-- vim.cmd("nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
-- vim.cmd("nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")
-- scroll down hover doc or scroll in definition preview
-- vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
-- vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
-- vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
-- Hover doc popup

-- local pop_opts = { border = "rounded", max_width = 80 }
-- handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, pop_opts)
-- handlers["textDocument/signatureHelp"] = vim.lsp.with(handlers.signature_help, pop_opts)



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

-- for ls_type, props in pairs(Settings.language_servers) do
--   if props.enabled == true then
--     if props.Settings_init then props.Settings_init(capabilities) end
--     lspconfig[ls_type].setup(props.setup or {
--       capabilities = capabilities,
--       on_attach = function(client, bufnr)
--         lspUtils.documentHighlight(client, bufnr)
--       end,
--       root_dir = function(_)
--         return vim.loop.cwd()
--       end
--     })
--   end
-- end


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
--
-- local sumneko_root_path = ""
-- local sumneko_binary = ""
--
-- if vim.fn.has("mac") == 1 then
--   sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/ls/lua-language-server"
--   sumneko_binary = "/Users/" .. USER .. "/.config/nvim/ls/lua-language-server/bin/macOS/lua-language-server"
-- elseif vim.fn.has("unix") == 1 then
--   sumneko_root_path = "/home/" .. USER .. "/.config/nvim/ls/lua-language-server"
--   sumneko_binary = "/home/" .. USER .. "/.config/nvim/ls/lua-language-server/bin/Linux/lua-language-server"
-- elseif vim.fn.has("win32") == 1 then
--   sumneko_root_path = "C:\\Users\\" .. USER .. "\\AppData\\Local\\nvim\\ls\\lua-language-server"
--   sumneko_binary = "C:\\Users" .. USER .. "\\AppData\\Local\\nvim\\ls\\lua-language-server\\bin\\Windows\\lua-language-server"
-- elseif Settings.language_servers.sumneko_lua['root_path'] ~= nil then
--   sumneko_root_path = Settings.language_servers.sumneko_lua.root_path
--   sumneko_binary = Settings.language_servers.sumneko_lua.binary_path
-- else
--   print("Unsupported system for sumneko")
-- end
--
-- if Settings.language_servers.sumneko_lua.enabled and sumneko_binary ~= "" and not Settings.utils.file.exists(sumneko_binary) then
--   print('Unable to load Sumneko language server.  Make sure it is installed in ' .. sumneko_root_path)
-- else
--   local luadev = Settings.utils.plugins.require('lua-dev')
--   local lua_lsp_config = {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--     settings = {
--       Lua = {
--         runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
--         diagnostics = {globals = {'vim'}},
--         workspace = {library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}, preloadFileSize = 450}
--       }
--     }
--   }
--
--   if luadev ~= nil then lua_lsp_config = luadev.setup {lspconfig = lua_lsp_config} end
--
--   require'lspconfig'.sumneko_lua.setup(lua_lsp_config)
-- end

-- Diagnostics

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Show icons in autocomplete
-- require('vim.lsp.protocol').CompletionItemKind = {
--   '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ', '﬌ ', ' ', ' ', '', ' ', ' ',
--   ' ', ' ', '', '', '<>'
-- }
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
