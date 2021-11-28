local nvim_lsp = require("lspconfig")

-- npm install -g typescript typescript-language-server
-- require'snippets'.use_suggested_mappings()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- local on_attach_common = function(client)
-- print("LSP Initialized")
-- require'illuminate'.on_attach(client)
-- end
-- 
-- vim.api.nvim_exec([[
-- autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
-- autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
-- autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
-- ]], false)

-- local format_async = function(err, _, result, _, bufnr)
--     if err ~= nil or result == nil then return end
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
--
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

require'lspconfig'.tsserver.setup {
    cmd = {DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio"},
    capabilities = require'lsp'.capabilities,

    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    on_attach = require'lsp'.tsserver_on_attach,
    -- on_attach = require'lsp'.tsserver_on_attach,
    -- This makes sure tsserver is not used for formatting (I prefer prettier)
    -- on_attach = require'lsp'.common_on_attach,
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    -- settings = { documentFormatting = true },
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.lang.tsserver.diagnostics.virtual_text,
            signs = O.lang.tsserver.diagnostics.signs,
            underline = O.lang.tsserver.diagnostics.underline,
            -- update_in_insert = true fucks up text as I'm typing - don't like it
            update_in_insert = false 
        }),
    }
}
