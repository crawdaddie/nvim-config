vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true})

vim.api.nvim_set_keymap('n', '<M-j>', ':resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':resize +2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-h>', ':vertical resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-l>', ':vertical resize +2<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = false})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = false})

vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

if Settings.plugins.nvim_comment.enabled then vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<cr>', {noremap = true, silent = true}) end

vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')
vim.cmd("vnoremap // y/\\V<C-R>=escape(@\",'/\')<CR><CR>")

-- save buffer
vim.api.nvim_set_keymap('n', '<C-s>', ':w!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w!<CR>', {noremap = true, silent = true})
-- leave vim
vim.api.nvim_set_keymap("n", "<C-c><C-d>", ":wqa!<CR>", { noremap = true })

-- lsp
vim.api.nvim_set_keymap("n", "<leader>r", ":Lspsaga rename<CR>", { noremap = true, silent = true })
vim.cmd("nnoremap <silent> ca :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> <leader>k :Lspsaga hover_doc<CR>")

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd('nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')

-- supercollider
vim.api.nvim_set_keymap('n', '<C-a>', ':SCNvimSendBlock<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<c-o>:SCNvimSendBlock<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-.>', ':SCNvimCmdPeriod<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-.>', ':SCNvimCmdPeriod<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>sr', ':SCNvimRecompile<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sb', ':SCNvimStart<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sx', ':SCNvimCmdPeriod<CR>', { noremap = true, silent = true})





