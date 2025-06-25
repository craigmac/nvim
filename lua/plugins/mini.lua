require('mini.pairs').setup()
local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup({
  -- see treesitter textobjects defined for a language: `:=vim.treesitter.query.get('<lang>', 'textobjects')`
  custom_textobjects = {
    -- switch to using treesitter
    f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
    e = function() -- whole buffer textobject
      local from = { line = 1, col = 1 }
      local to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) }
      return { from = from, to = to }
    end
  },
  silent = true,
})

require('mini.align').setup({
  mappings = {
    start_with_preview = 'gl',
    start = 'gL',
  },
  silent = true,
})

require('mini.icons').setup({})
require('mini.snippets').setup({})

-- scroll info/signature window with <C-f> and <C-b>
require('mini.completion').setup({
  window = { info = { border = 'single' }, signature = { border = 'single' } },
  -- disables these, conflict with my wezterm and system mappings
  mappings = { force_twostep = '', force_fallback = '' }
})




