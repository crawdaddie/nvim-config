vim.api.nvim_exec([[
  autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  set title
]], false)
