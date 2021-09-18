local M = {}
M.config = function()
    local g = vim.g

    vim.o.termguicolors = true

    g.nvim_tree_side = "left"
    g.nvim_tree_width = 30
    g.nvim_tree_ignore = {".DS_Store", ".git", "node_modules", ".cache"}
    g.nvim_tree_auto_open = 1
    g.nvim_tree_auto_close = 1
    g.nvim_tree_quit_on_open = 0
    g.nvim_tree_follow = 1
    g.nvim_tree_indent_markers = 0
    g.nvim_tree_hide_dotfiles = 0
    g.nvim_tree_git_hl = 1
    g.nvim_tree_root_folder_modifier = ":t"
    g.nvim_tree_tab_open = 0
    g.nvim_tree_allow_resize = 1
    g.nvim_tree_lsp_diagnostics = 1
    g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}

    g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0
    }

    vim.g.nvim_tree_icons = {
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

    local tree_cb = require"nvim-tree.config".nvim_tree_callback

    -- g.nvim_tree_bindings = {
    --     ["<CR>"] = tree_cb("edit"),
    --     ["l"] = tree_cb("edit"),
    --     ["o"] = tree_cb("edit"),
    --     ["h"] = tree_cb("close_node"),
    --     ["<2-LeftMouse>"] = tree_cb("edit"),
    --     ["<2-RightMouse>"] = tree_cb("cd"),
    --     ["<C-]>"] = tree_cb("cd"),
    --     ["<C-v>"] = tree_cb("vsplit"),
    --     ["v"] = tree_cb("vsplit"),
    --     ["<C-x>"] = tree_cb("split"),
    --     ["<C-t>"] = tree_cb("tabnew"),
    --     ["<"] = tree_cb("prev_sibling"),
    --     [">"] = tree_cb("next_sibling"),
    --     ["<BS>"] = tree_cb("close_node"),
    --     ["<S-CR>"] = tree_cb("close_node"),
    --     ["<Tab>"] = tree_cb("preview"),
    --     ["I"] = tree_cb("toggle_ignored"),
    --     ["H"] = tree_cb("toggle_dotfiles"),
    --     ["R"] = tree_cb("refresh"),
    --     ["a"] = tree_cb("create"),
    --     ["d"] = tree_cb("remove"),
    --     ["r"] = tree_cb("rename"),
    --     ["<C-r>"] = tree_cb("full_rename"),
    --     ["x"] = tree_cb("cut"),
    --     ["c"] = tree_cb("copy"),
    --     ["p"] = tree_cb("paste"),
    --     ["y"] = tree_cb("copy_name"),
    --     ["Y"] = tree_cb("copy_path"),
    --     ["gy"] = tree_cb("copy_absolute_path"),
    --     ["[c"] = tree_cb("prev_git_item"),
    --     ["]c"] = tree_cb("next_git_item"),
    --     ["-"] = tree_cb("dir_up"),
    --     ["q"] = tree_cb("close")
    -- }
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-}>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = {"<BS>", "h"},                  cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "l",                            cb = tree_cb("open_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C->",                         cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "}c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
end


-- M.toggle_tree = function()
-- local view = require'nvim-tree.view'
-- local bufferline_state = require'bufferline.state'
--     if view.win_open() then
--         require'nvim-tree'.close()
--         bufferline_state.set_offset(0)
--     else
--         bufferline_state.set_offset(21, 'File Explorer')
--         require'nvim-tree'.find_file(true)
--     end
-- 
-- end
-- 
vim.api.nvim_set_keymap('n', '<leader>e',":NvimTreeToggle<CR>",{noremap = false, silent = true})
return M