vim.cmd('filetype plugin indent on')
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.hidden = true
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.conceallevel = 0
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.cmdheight = 1 -- More space for displaying messages
vim.cmd('syntax on') -- syntax highlighting

vim.wo.wrap = false
vim.wo.number = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
vim.wo.relativenumber = true -- set relative number

vim.o.tabstop = Settings.options.tabwidth
vim.bo.tabstop = Settings.options.tabwidth
vim.o.softtabstop = Settings.options.tabwidth
vim.bo.softtabstop = Settings.options.tabwidth
vim.o.shiftwidth = Settings.options.tabwidth
vim.bo.shiftwidth = Settings.options.tabwidth
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

-- vim.opt.dictionary:append("/usr/share/dict/words")
--vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
--vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
--vim.cmd('set inccommand=split') -- Make substitution work in realtime
--
--vim.o.hidden = O.hidden_files -- Required to keep multiple buffers open multiple buffers
--vim.o.title = true
--TERMINAL = vim.fn.expand('$TERMINAL')
--vim.cmd('let &titleold="'..TERMINAL..'"')
--vim.o.titlestring="%<%F%=%l/%L - nvim"
--vim.wo.wrap = O.wrap_lines -- Display long lines as just one line
--vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
---- vim.o.pumheight = 10 -- Makes popup menu smaller
--vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.cmd('set colorcolumn=99999') -- fix indentline for now
--vim.o.splitbelow = true -- Horizontal splits will automatically be below
--vim.cmd('set ts=4') -- Insert 2 spaces for a tab
--vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
--vim.cmd('set expandtab') -- Converts tabs to spaces
--vim.o.completeopt = "menuone,noselect"
--vim.bo.smartindent = true -- Makes indenting smart
--vim.wo.number = O.number -- set numbered lines
--vim.wo.cursorline = O.cursorline -- set highlighting of the current line
--vim.o.showtabline = 2 -- Always show tabs
--vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
--vim.o.backup = false -- This is recommended by coc
--vim.o.writebackup = false -- This is recommended by coc
vim.o.swapfile = false -- Do not write any swp files
--vim.o.undodir = CACHE_PATH .. '/undo' -- Set undo directory
--vim.o.undofile = true -- Enable persistent undo
--vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
--vim.o.updatetime = 300 -- Faster completion
--vim.o.timeoutlen = O.timeoutlen -- By default timeoutlen is 1000 ms
--vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
--vim.o.smartcase = O.smart_case
--vim.g.gitblame_enabled = 0
--
-- vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'black', bold = true })
