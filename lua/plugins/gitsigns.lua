local gitsigns = require('gitsigns')
gitsigns.setup({
  signs_staged_enable = false,
  signcolumn = false, -- off by default instead of on
  on_attach = function(bufnr)
    vim.keymap.set('n', 'yog', gitsigns.toggle_signs)

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    vim.keymap.set('x', '<Leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    vim.keymap.set('x', '<Leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)

    vim.keymap.set('n', '<Leader>hs', gitsigns.stage_hunk)
    vim.keymap.set('n', '<Leader>hr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<Leader>hR', gitsigns.reset_buffer)
    vim.keymap.set('n', '<Leader>hp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<Leader>hb', gitsigns.blame_line)
    vim.keymap.set('n', '<Leader>hd', gitsigns.diffthis)
    -- diff with version of file in the commit referenced by '@' aka HEAD
    vim.keymap.set('n', '<Leader>hD', function() gitsigns.diffthis('@') end)
  end,
})
