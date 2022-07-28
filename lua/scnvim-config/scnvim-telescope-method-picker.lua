local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local uv = vim.loop
local api = vim.api
local helpSource = '/Users/adam/Library/Application Support/SuperCollider/Help'

local methods


local function concat(...)
  local items = { ... }
  return table.concat(items, '/')
end

local function open_win(uri, pattern)
  buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")


  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  -- print('cursor ' .. r .. ' ' .. c .. ' ' .. width .. ' ' .. height)

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  -- local win_height = 64
  -- local win_width = 96
  -- local win_height = math.ceil(math.min(c + 64, height * 0.8 - 4) - c)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
  }

  win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, "cursorline", true)

  local expr = string.format('edit %s', uri)
  if pattern then
    expr = string.format('edit +/%s %s', pattern, uri)
  end

  vim.cmd(expr)
  return win
end

local function get_docmap(target_dir)
  if methods then
    return methods
  end
  local stat = uv.fs_stat(target_dir)
  assert(stat, 'Could not find docmap.json')
  local fd = uv.fs_open(target_dir, 'r', 0)
  local size = stat.size
  local file = uv.fs_read(fd, size, 0)
  local ok, docmap = pcall(vim.fn.json_decode, file)
  uv.fs_close(fd)
  if not ok then
    error(docmap)
  end
  local results = {}

  for t, value in pairs(docmap) do
    table.insert(results, {
      value.title
    })
    local destPath = ''
    local methodName = ''
    for _, method in ipairs(value.methods) do
      destpath = concat(target_dir, value.path .. '.txt')
      methodName = method:gsub('[-?]', '')
      table.insert(results, {
        string.format('%s.%s', value.title, methodName),
        string.format('%s/%s.txt', helpSource, t),
        methodName,
        value.title
        -- methodName:gsub('*', value.title)
        -- destpath,
        -- string.format('^\\.%s', method),
      })
    end
  end
  methods = results

  return results
end

local M = {}

M.sc_picker = function(subject, opts)
  print(subject)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "methods",
    finder = finders.new_table {
      results = get_docmap(concat(helpSource, 'docmap.json')),
      entry_maker = function(entry)
        return {
          value = entry[1],
          display = entry[1],
          ordinal = entry[1],
          class = entry[4],
          method = entry[3],
          path = entry[2],
          -- filename = entry[3],
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry, status)
        return { 'cat', entry.path }
      end
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local pattern = ''
        if string.sub(selection.method, 1, #'*') == '*' then
          pattern = selection.method:gsub('*', selection.class .. '.')
        else
          pattern = '.' .. selection.method
        end
        print(selection.path .. ' - ' .. pattern)
        open_win(selection.path, pattern)
      end)
      return true
    end,

  }):find()
end


-- {
--   class = "Pgbman",
--   display = "Pgbman.n",
--   index = 39,
--   method = "n",
--   ordinal = "Pgbman.n",
--   path = "/Users/adam/Library/Application Support/SuperCollider/Help/Classes/Pgbman.txt",
--   value = "Pgbman.n"
-- }
-- {
--   class = "NodeSettings",
--   display = "NodeSettings.*serializeNodeValue",
--   index = 11,
--   method = "*serializeNodeValue",
--   ordinal = "NodeSettings.*serializeNodeValue",
--   path = "/Users/adam/Library/Application Support/SuperCollider/Help/Classes/NodeSettings.txt",
--   value = "NodeSettings.*serializeNodeValue"
-- }
-- to execute the function
-- get_docmap('/Users/adam/Library/Application Support/SuperCollider/Help/docmap.json')
sc_picker()
-- our picker function: colors
