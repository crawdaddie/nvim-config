vim.cmd("colorscheme seoul256-light")
-- vim.cmd("highlight clear CursorLineNr")
vim.cmd("highlight Comment gui=italic")
vim.cmd("highlight WinSeparator guibg=None guifg=#d0d0d0")
-- vim.cmd("hi @variable guifg=0")


-- if client.server_capabilities.document_highlight then
--     vim.api.nvim_exec([[
-- hi LspDiagnosticsDefaultError gui=italic guifg=#ef7872
-- hi LspDiagnosticsDefaultWarning gui=italic guifg=#f4a46e
-- hi LspDiagnosticsDefaultHint gui=italic guifg=#ffffff
-- hi LspDiagnosticsDefaultInformation gui=italic guifg=#ffffff
-- hi link LspDiagnosticsDefaultHint DiagnosticHint
-- hi link LspDiagnosticsDefaultInformation DiagnosticInfo
-- hi! link DiagnosticHint #6a6765
-- hi! link DiagnosticInfo #6a6765
--
--
--
--
-- hi LspReferenceRead cterm=bold ctermbg=red guibg=#d9d8d3
-- hi LspReferenceText cterm=bold ctermbg=red guibg=#d9d8d3
-- hi LspReferenceWrite cterm=bold ctermbg=red guibg=#d9d8d3
--
-- augroup lsp_document_highlight
--     autocmd! * <buffer>
--     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- augroup END]],
