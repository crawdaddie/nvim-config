local utils = {}
local documentHighlight = function(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
    hi LspDiagnosticsDefaultError gui=italic guifg=#ef7872
    hi LspDiagnosticsDefaultWarning gui=italic guifg=#f4a46e
    hi LspDiagnosticsDefaultHint gui=italic guifg=#6a6765
    hi LspDiagnosticsDefaultInformation gui=italic guifg=#6a6765
    hi link LspDiagnosticsDefaultHint DiagnosticHint
    hi link LspDiagnosticsDefaultInformation DiagnosticInfo
    hi! link DiagnosticHint #6a6765
    hi! link DiagnosticInfo #6a6765




    hi LspReferenceRead cterm=bold ctermbg=red guibg=#d9d8d3
    hi LspReferenceText cterm=bold ctermbg=red guibg=#d9d8d3
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=#d9d8d3

    augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END]],
            false
        )
    end
end

local documentAutoFormat = function ()
  vim.cmd [[
    augroup Format
      au! * <buffer>
      au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup END
  ]]
end

utils.documentHighlight = documentHighlight
utils.documentAutoFormat = documentAutoFormat
return utils
