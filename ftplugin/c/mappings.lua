-- vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>ii', ':lua CurtineIncSw()<CR>', { silent = true })
-- vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>iv', ':lua CurtineIncSw("v")<CR>', { silent = true })

-- vim.cmd 'nnoremap <silent> gh :ClangdSwitchSourceHeader<CR>'
-- Create the function
local function switch_source_header()
  local method_name = 'textDocument/switchSourceHeader'
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not client then
    return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client.request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify 'corresponding file cannot be determined'
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

-- Create the command
vim.api.nvim_create_user_command('ClangdSwitchSourceHeader', switch_source_header, {})

-- Set up your keymap
vim.keymap.set('n', 'gh', switch_source_header, { desc = 'Switch Source/Header' })

-- Optional: Unset the keymap when the ftplugin is unloaded
function _G.unload_c_mappings()
  vim.api.nvim_buf_del_keymap(0, 'n', '<Leader>i')
end

-- Optional: Set up an autocmd to call the unload function
-- vim.cmd([[
--   augroup c_ftplugin
--     autocmd!
--     autocmd BufUnload <buffer> lua unload_c_mappings()
--   augroup END
-- ]])
