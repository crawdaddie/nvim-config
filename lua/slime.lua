local repl = "utop"
local repl_id
local cmd

local function dune_proj()
  local found = vim.fn.findfile("dune", ".;")
  if found ~= "" then
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
