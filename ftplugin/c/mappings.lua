vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>ii', ':lua CurtineIncSw()<CR>', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>iv', ':lua CurtineIncSw("v")<CR>', { silent = true })

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
