return {
  'lewis6991/gitsigns.nvim',
  cond = (not vim.g.vscode) and (not vim.g.firenvim),
  dependencies = {
  },
  opts = {
    signs_staged_enable = false,
    signcolumn = true,
    on_attach = function(_bufnr)
      local gitsigns = require('gitsigns')
      vim.keymap.set('n', 'yog', gitsigns.toggle_signs)

      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = 'Next git change hunk' })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = 'Previous git change hunk' })

      vim.keymap.set({ 'x', 'n' }, '<Leader>hs', function()
        gitsigns.stage_hunk()
      end, { desc = 'Hunk stage' })

      vim.keymap.set('n', '<Leader>hS', function()
        gitsigns.stage_buffer()
      end, { desc = 'Stage all hunks in buffer' })

      vim.keymap.set({ 'x', 'n' }, '<Leader>hr', function()
        gitsigns.reset_hunk()
      end, { desc = 'Reset hunk' })

      vim.keymap.set('n', '<Leader>hR', function()
        gitsigns.reset_buffer()
      end, { desc = 'Reset all hunks in buffer' })

      vim.keymap.set('n', '<Leader>hp', function()
        gitsigns.preview_hunk()
      end, { desc = 'Preview hunk change in popup' })

      vim.keymap.set('n', '<Leader>hb', function()
        gitsigns.blame_line()
      end, { desc = 'Show git blame of current line' })

      vim.keymap.set('n', '<Leader>hd', function()
        gitsigns.diffthis()
      end, { desc = 'Git hunk diffthis' })
    end,
  },
}
