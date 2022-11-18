local g = vim.g
-- vim.o.termguicolors = true

local tree_cb = require "nvim-tree.config".nvim_tree_callback
local bindings = {
  { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
  { key = { "<2-RightMouse>", "<C-}>" }, cb = tree_cb("cd") },
  { key = "<C-v>", cb = tree_cb("vsplit") },
  { key = "<C-x>", cb = tree_cb("split") },
  { key = "<C-t>", cb = tree_cb("tabnew") },
  { key = "<", cb = tree_cb("prev_sibling") },
  { key = ">", cb = tree_cb("next_sibling") },
  { key = "P", cb = tree_cb("parent_node") },
  { key = { "<BS>", "h" }, cb = tree_cb("close_node") },
  { key = "<S-CR>", cb = tree_cb("close_node") },
  { key = "l", cb = tree_cb("open_node") },
  { key = "<Tab>", cb = tree_cb("preview") },
  { key = "K", cb = tree_cb("first_sibling") },
  { key = "J", cb = tree_cb("last_sibling") },
  { key = "I", cb = tree_cb("toggle_ignored") },
  { key = "H", cb = tree_cb("toggle_dotfiles") },
  { key = "R", cb = tree_cb("refresh") },
  { key = "a", cb = tree_cb("create") },
  { key = "d", cb = tree_cb("remove") },
  { key = "r", cb = tree_cb("rename") },
  { key = "<C->", cb = tree_cb("full_rename") },
  { key = "x", cb = tree_cb("cut") },
  { key = "c", cb = tree_cb("copy") },
  { key = "p", cb = tree_cb("paste") },
  { key = "y", cb = tree_cb("copy_name") },
  { key = "Y", cb = tree_cb("copy_path") },
  { key = "gy", cb = tree_cb("copy_absolute_path") },
  { key = "[c", cb = tree_cb("prev_git_item") },
  { key = "}c", cb = tree_cb("next_git_item") },
  { key = "-", cb = tree_cb("dir_up") },
  { key = "q", cb = tree_cb("close") },
  { key = "g?", cb = tree_cb("toggle_help") },
}



require 'nvim-tree'.setup {
  renderer = {
    root_folder_modifier = ":t",
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false
      },
      glyphs = {
        default = ' ',
        symlink = ' ',
        git = {
          unstaged = "*",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌"
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = ""
        }
      }
    },
  },
  disable_netrw = false,
  hijack_netrw = true,
  open_on_setup = true,
  ignore_ft_on_setup = { 'dashboard' },
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    -- cmd = open,
    -- the command arguments as a list
    args = { "-R" }
  },
  git = {
    enable = true,
    ignore = true
  },
  view = {
    width = 25,
    side = 'left',
    mappings = { custom_only = false, list = bindings }
  },
  filters = {
    custom = { ".DS_Store", ".git", "node_modules", ".cache" },
    dotfiles = false,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
}
