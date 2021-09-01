require'nvim-treesitter.configs'.setup {
    matchup = {
        enable = true-- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
        enable = true,
        disable = { "supercollider" }
    },
    context_commentstring = {enable = O.plugin.ts_context_commentstring, config = {css = '// %s'}},
    indent = {enable = true},
    autotag = {enable = true},
}

