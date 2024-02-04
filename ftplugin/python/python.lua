function open_win(cmd)
  buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")


  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_width = 96
  local win_height = math.ceil(math.min(c + 64, height * 0.8 - 4) - c)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "cursor",
    width = win_width,
    height = win_height,
    row = 1,
    col = 0,
    -- border = "rounded",
  }

  win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, "cursorline", true)
  --
  local expr = string.format('0read !%s', cmd)
  vim.cmd(expr)
  return win
end

function OpenPythonHelp(obj)
  local term = ""
  if obj.args ~= "" then
    term = obj.args
  else
    term = vim.fn.input("=> ", term)
  end
  local cmd = "\"help('" .. term .. "')\""
  cmd = "python -c " .. cmd

  -- vim.cmd("vnew | 0read !" .. cmd)
  open_win(cmd)
end

vim.api.nvim_create_user_command("PythonHelp", OpenPythonHelp, { nargs = '?' })
