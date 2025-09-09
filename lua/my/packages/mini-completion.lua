-- https://github.com/nvim-mini/mini.completion
-- <C-f> and <C-b> for info/sig. window scrolling
require('mini.completion').setup({
  mappings = {
    -- disable <C-Space> and <M-Space> default bindings
    force_twostep = '',
    force_fallback = '',
  }
})
