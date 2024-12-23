-- requires flit.nvim also if you want f/t motions support, or just use flash.nvim

-- default visual S mapping conflicts with vim-surround/nvim-surround defaults
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'o'}, 'S',  '<Plug>(leap-backward)')

-- jump to any window
vim.keymap.set({'n', 'x', 'o'}, '<Leader>s', '<Plug>(leap-from-window)')

