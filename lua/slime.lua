local repl = "utop"
local repl_id
local cmd

local function dune_proj()
  local found_dune = vim.fn.findfile("dune", ".;")
  local found_dune_project = vim.fn.findfile("dune-project", ".;")
  if found_dune ~= "" or found_dune_project ~= "" then
    return true
  else
    return false
  end
end


function GetMlId()
  if repl_id ~= nil then
    print(repl_id)
  else
    print("No Active Repl...")
  end
end

function OpenOcamlRepl()
  if cmd == nil then
    if dune_proj() then
      cmd = "dune" .. " " .. repl
    else
      cmd = repl
    end
  end
  cmd = vim.fn.input("=> ", cmd)
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd L]]
  repl_id = vim.fn.termopen(cmd)
  print("replid: " .. repl_id)

  vim.cmd [[wincmd h]]
  vim.cmd("let b:slime_config = {\"jobid\": " .. repl_id .. "}")

  vim.cmd("set syntax=ocaml")
end

function OpenPythonRepl()
  cmd = "ipython"
  cmd = vim.fn.input("=> ", cmd)
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd L]]
  repl_id = vim.fn.termopen(cmd)
  print("replid: " .. repl_id)

  vim.cmd [[wincmd h]]
  vim.cmd("let b:slime_config = {\"jobid\": " .. repl_id .. "}")

  vim.cmd("set syntax=python")
end

function OpenSicpRepl()
  cmd = "racket -l sicp --repl"
  cmd = vim.fn.input("=> ", cmd)
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd L]]
  repl_id = vim.fn.termopen(cmd)
  print("replid: " .. repl_id)
  vim.cmd [[wincmd h]]
  vim.cmd("let b:slime_config = {\"jobid\": " .. repl_id .. "}")
  vim.cmd("set syntax=scheme")
end

local term_buf
local term_win


vim.cmd([[
function! _EscapeText_ylc(text)
  let lines = split(a:text, '\n', 1)

  if len(lines) <= 1
    return [a:text, "\n\n"]  " Add a newline for single-line commands
  endif

  let result = []

  for i in range(len(lines) - 1)
    let line = lines[i]
    " If line contains non-whitespace
    if line =~ '\S'
      " Add continuation character
      call add(result, line . ' \')
    endif
  endfor

  " Add the last line if it's not empty, without continuation character
  if lines[-1] =~ '\S'
    call add(result, lines[-1])
  endif

  " Join the lines and add a final newline
  return [join(result, "\n"), "\n\n"]
endfunction
]])

function OpenYlcRepl()
  -- Store the current buffer (this will be our REPL buffer)
  local repl_buf = vim.api.nvim_get_current_buf()
  local repl_win = vim.api.nvim_get_current_win()

  -- -- Kill existing terminal process if it exists
  -- if repl_id and vim.api.nvim_chan_is_valid(repl_id) then
  --   vim.fn.jobstop(repl_id)
  -- end
  -- -- Close existing terminal window if it exists
  -- if term_win and vim.api.nvim_win_is_valid(term_win) then
  --   vim.api.nvim_win_close(term_win, true)
  -- end

  -- Create a new window to the right for the terminal
  vim.cmd('vsplit')
  vim.cmd('wincmd L')
  term_win = vim.api.nvim_get_current_win()

  -- Prompt for the command
  ---- Get the current buffer's filename
  local current_file = vim.fn.expand('%:p')

  -- Prompt for the command, including the current filename
  local cmd = vim.fn.input("=> ", "ylc " .. current_file .. " -i")
  -- local cmd = vim.fn.input("=> ", "ylc -i")

  -- Start the terminal in the new window
  term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(term_win, term_buf)
  repl_id = vim.fn.termopen(cmd, {
    on_stdout = function(_, _, _)
      if vim.api.nvim_win_is_valid(term_win) then
        vim.schedule(function()
          vim.api.nvim_win_set_cursor(term_win, { vim.api.nvim_buf_line_count(term_buf), 0 })
        end)
      end
    end
  })


  -- Move focus back to the original REPL window
  vim.api.nvim_set_current_win(repl_win)

  -- Set buffer-local variables and syntax for the REPL buffer
  vim.api.nvim_buf_set_var(repl_buf, 'slime_config', { jobid = repl_id })
  vim.api.nvim_buf_set_option(repl_buf, 'syntax', 'ylc')
  vim.api.nvim_buf_set_option(repl_buf, 'filetype', 'ylc')
end
