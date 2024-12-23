-- Better wellle/targets.vim with treesitter textobjects support
-- supports (n)ext and (l)ast e.g., `cin(`, `val[`,
-- goto edges of textobject: `g[` and `g]`
require('mini.ai').setup()

-- require('mini.statusline').setup()

-- also provides 'ai' and 'ii' textobjects for (a)round/(i)nside (i)ndent level
-- require('mini.indentscope').setup({ symbol = '│' })

-- I like this better than vim-easy-align and vim-lion
-- because of preview support
require('mini.align').setup({
  mappings = {
    start = 'g=',
    start_with_preview = '<Leader>g=',
  },
})
