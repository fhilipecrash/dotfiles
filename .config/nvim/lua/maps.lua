local keymap = vim.keymap
vim.g.mapleader = ','

keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { silent = true })
keymap.set('n', '<S-b>', ':NvimTreeFocus<CR>', { silent = true })
keymap.set('n', '<leader>r', ':so %<CR>')
