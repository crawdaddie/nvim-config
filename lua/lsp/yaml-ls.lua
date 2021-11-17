-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
	cmd = {DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server", "--stdio"},
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_highlight = true
        require'lsp'.common_on_attach(client, bufnr)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false
        }) 
    }
}
