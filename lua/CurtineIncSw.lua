function FindInc(v)
  local dirname = vim.fn.fnamemodify(vim.fn.expand '%:p', ':h')
  local target_file = vim.b.inc_sw
  -- At this point cmd might evaluate to something of the format:
  -- /Users/person/ . -type f -iregex ".*\/test_class.h[a-z]*" -print -quit
  local cmd = 'find ' .. dirname .. " -not -path . -type f -not -path '" .. dirname .. '/.ccls-cache/*\' -iregex "' .. target_file .. '" -print -quit'
  local find_res = vim.fn.system(cmd)
  if vim.fn.filereadable(find_res) == 1 then
    return 0
  end
  if v == 'v' then
    vim.cmd('vsplit ' .. find_res)
  else
    vim.cmd('e ' .. find_res)
  end
end

function CurtineIncSw(v)
  if vim.b.inc_sw ~= nil then
    vim.cmd 'e#'
    return 0
  end

  if vim.fn.match(vim.fn.expand '%', '\\.c') > 0 then
    vim.b.inc_sw = vim.fn.substitute('.*\\/' .. vim.fn.expand '%:t', '\\.c\\(.*\\)', '.h[a-z]*', '')
  elseif vim.fn.match(vim.fn.expand '%', '\\.h') > 0 then
    vim.b.inc_sw = vim.fn.substitute('.*\\/' .. vim.fn.expand '%:t', '\\.h\\(.*\\)', '.c[a-z]*', '')
  elseif vim.fn.match(vim.fn.expand '%', '\\.ads') > 0 then
    vim.l.inc_sw = vim.fn.substitute('.*\\/' .. vim.fn.expand '%:t', '\\.ads\\(.*\\)', '.adb[a-z]*', '')
  elseif vim.fn.match(vim.fn.expand '%', '\\.adb') > 0 then
    vim.l.inc_sw = vim.fn.substitute('.*\\/' .. vim.fn.expand '%:t', '\\.adb\\(.*\\)', '.ads[a-z]*', '')
  end

  FindInc(v)
end

vim.api.nvim_command 'au BufReadPost * if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif'
