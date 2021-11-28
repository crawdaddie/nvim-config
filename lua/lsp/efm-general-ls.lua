-- Example configuations here: https://github.com/mattn/efm-langserver
-- TODO this file needs to be refactored eache lang should be it's own file
-- python
local python_arguments = {}

-- TODO replace with path argument
local flake8 = {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local isort = {formatCommand = "isort --quiet -", formatStdin = true}

local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
local black = {formatCommand = "black --quiet -", formatStdin = true}

if O.lang.python.linter == 'flake8' then table.insert(python_arguments, flake8) end

if O.lang.python.isort then table.insert(python_arguments, isort) end

if O.lang.python.formatter == 'yapf' then
    table.insert(python_arguments, yapf)
elseif O.lang.python.formatter == 'black' then
    table.insert(python_arguments, black)
end

-- lua
local lua_arguments = {}

local luaFormat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=80",
    formatStdin = true
}

local lua_fmt = {
    formatCommand = "luafmt --indent-count 2 --line-width 120 --stdin",
    formatStdin = true
}

if O.lang.lua.formatter == 'lua-format' then
  table.insert(lua_arguments, luaFormat)
elseif O.lang.lua.formatter == 'lua-fmt' then
  table.insert(lua_arguments, lua_fmt)
end

-- sh
local sh_arguments = {}

local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}

local shellcheck = {
    LintCommand = 'shellcheck -f gcc -x',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
}

if O.lang.sh.formatter == 'shfmt' then table.insert(sh_arguments, shfmt) end

if O.lang.sh.linter == 'shellcheck' then table.insert(sh_arguments, shellcheck) end

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = {
    formatCommand = "~/.yarn/bin/prettierd \"${INPUT}\"", formatStdin = true
}
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local tsserver_args = {}


if O.lang.tsserver.formatter == 'prettier' then table.insert(tsserver_args, prettier) end

if O.lang.tsserver.linter == 'eslint' then table.insert(tsserver_args, eslint) end

-- local markdownlint = {
--     -- TODO default to global lintrc
--     -- lintcommand = 'markdownlint -s -c ./markdownlintrc',
--     lintCommand = 'markdownlint -s',
--     lintStdin = true,
--     lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
-- }

local markdownPandocFormat = {formatCommand = 'pandoc -f markdown -t gfm -sp --tab-stop=2', formatStdin = true}

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.goto_definition = false
        vim.cmd [[
            augroup Format
              au! * <buffer>
              au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
            augroup END
          ]]
    end,
    filetypes = {"lua", "python", "javascriptreact", "javascript", "typescript","typescriptreact","sh", "html", "css", "yaml", "markdown", "vue"},
    -- handlers = {
    --     ["textDocument/publishDiagnostics"] = function() end
    -- },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = python_arguments,
            lua = lua_arguments,
            sh = sh_arguments,
            javascript = tsserver_args,
            javascriptreact = tsserver_args,
			typescript = tsserver_args,
			typescriptreact = tsserver_args,
            html = {prettier},
            css = {prettier},
            json = {prettier},
            yaml = {prettier},
            markdown = {markdownPandocFormat},
            supercollider = {prettier}
            -- javascriptreact = {prettier, eslint},
            -- javascript = {prettier, eslint},
            -- markdown = {markdownPandocFormat, markdownlint},
        }
    }
}

-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim
