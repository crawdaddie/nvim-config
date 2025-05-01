local dap = require('dap')
local current_config
dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",

    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,

    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  },
}

local function load_json_config(filename)
  print("loading  " .. filename)
  local file = io.open(filename, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return vim.fn.json_decode(content)
  end
  return nil
end

local function Debug()
  -- Prompt for filetype
  local function get_filetype(callback)
    vim.ui.input({
      prompt = 'Filetype (default: c): ',
    }, function(input)
      local filetype = input ~= "" and input or "c"
      callback(filetype)
    end)
  end

  local function get_configs(callback)
    -- Check for saved configs
    -- Check for saved configs using Vim's glob() function
    local configs = {}
    local config_files = vim.fn.glob('.dbg/*.json', false, true)
    for i, file in ipairs(config_files) do
      configs[i] = file
      -- vim.fn.fnamemodify(file, ':t') -- Get just the filename
    end
    callback(configs)
  end

  -- Create new config
  local function create_new_config(filetype, callback)
    vim.ui.input({
      prompt = 'Path to executable: ',
      default = vim.fn.getcwd() .. '/',
    }, function(program)
      if not program then return end

      local config = dap.configurations[filetype] and dap.configurations[filetype][1] or {
        name = "Launch",
        request = "launch",
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      }
      config.program = program

      vim.ui.input({
        prompt = 'Arguments: ',
      }, function(args_string)
        config.args = args_string ~= "" and vim.split(args_string, " ") or {}
        callback(config)
      end)
    end)
  end

  -- Select or create config
  local function select_or_create_config(configs, callback)
    if #configs > 0 then
      -- Add 'New' option to the beginning of the configs list
      table.insert(configs, #configs + 1, 'New')

      vim.ui.select(configs, {
        prompt = 'Select debug config:',
      }, function(choice)
        if choice then
          if choice == 'New' then
            get_filetype(function(filetype)
              create_new_config(filetype, callback)
            end)
          else
            local config = load_json_config(choice)
            callback(config)
          end
        else
          -- User cancelled the selection
          callback(nil)
        end
      end)
    else
      get_filetype(function(filetype)
        create_new_config(filetype, callback)
      end)
    end
  end


  -- Main execution flow
  get_configs(function(configs)
    select_or_create_config(configs, function(config)
      -- Run the debugger
      current_config = config
      dap.run(config)
    end)
  end)
end

local function save_dap_config_to_json()
  -- Get the current configuration
  local config = current_config

  -- Convert the configuration to JSON
  local json = vim.fn.json_encode(config)

  -- Ask the user for a file name
  local filename = vim.fn.input("Enter filename to save DAP config (default: dap_config.json): ", "dap_config.json")

  -- If user didn't enter anything, use the default
  if filename == "" then
    filename = "dap_config.json"
  end

  -- Ensure .dbg directory exists
  os.execute("mkdir -p .dbg")

  -- Write the JSON to the file
  local file = io.open(".dbg/" .. filename, "w")
  if file then
    file:write(json)
    file:close()
    print("DAP configuration saved to " .. ".dbg/" .. filename)
  else
    print("Failed to open file for writing: " .. filename)
  end
end

-- Add commands to call these functions
vim.api.nvim_create_user_command('Debug', Debug, {})
vim.api.nvim_create_user_command('SaveDapConfig', save_dap_config_to_json, {})
