require('mini.pairs').setup()
require('mini.icons').setup()

local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup({
  -- see treesitter textobjects defined for a language: `:=vim.treesitter.query.get('<lang>', 'textobjects')`
  custom_textobjects = {
    f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
    e = function() -- whole buffer textobject
      local from = { line = 1, col = 1 }
      local to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) }
      return { from = from, to = to }
    end
  },
  silent = true,
})

-- match vim-lion default keybinds
require('mini.align').setup({
  mappings = {
    start_with_preview = 'gl',
    start = 'gL',
  },
  silent = true,
})

require('mini.completion').setup({
  window = { info = { border = 'single' }, signature = { border = 'single' } },
  -- disables these, conflict with my wezterm and system mappings
  mappings = { force_twostep = '', force_fallback = '' }
})


-- mimic tpope/vim-surround mappings, dot repeat works too
require('mini.surround').setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    find = '',
    find_left = '',
    highlight = '',
    replace = 'cs',
    update_n_lines = '',
    suffix_last = '',
    suffix_next = '',
  },
  search_method = 'cover_or_next',
})
-- more tpope/vim-surround behaviour: visual S and yss for surround line
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
vim.keymap.set('n', 'yss', 'ys_', { remap = true })

-- use 's' instead of '<CR>' as jump key
require('mini.jump2d').setup({
  mappings = { start_jumping = 's' },
  silent = true,
})

