-- npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup {
    cmd = {DATA_PATH .. "/lspinstall/graphql/node_modules/.bin/graphql-lsp", "--stdio"},
    on_attach = require'lsp'.common_on_attach
}
