local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not lspconfig.supercollider then
  configs.supercollider = {
    default_config = {
      cmd = { '' };
      filetypes = { 'supercollider' };
      root_dir = function(fname)
        return vim.fn.getcwd()
      end;
    };
    settings = {};
    docs = {
      package_json = '';
      description = [[]];
      default_config = {
        root_dir = [[]];
      };
    };
  }
end

lspconfig.supercollider.setup {}
