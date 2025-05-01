local input
vim.ui.input({ prompt = "complete me: ", completion = 'dir' }, function(input) print(input) end)

vim.ui.select({ 'tabs', 'spaces' }, {
  prompt = 'Select tabs or spaces:',
  format_item = function(item)
    return "I'd like to choose " .. item
  end,
}, function(choice)
  if choice == 'spaces' then
    -- vim.o.expandtab = true
  else
    -- vim.o.expandtab = false
  end
end)
