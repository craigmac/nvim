local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return end

gitsigns.setup({
  signs_staged_enable = false,
  signcolumn = true,
  on_attach = function(_bufnr)
    -- show signs only when I toggle them on
    gitsigns.toggle_signs()
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

    vim.keymap.set({ 'x', 'n' }, '<Leader>hs', function() gitsigns.stage_hunk() end)
    vim.keymap.set('n', '<Leader>hS', function() gitsigns.stage_buffer() end)

    vim.keymap.set({ 'x', 'n' }, '<Leader>hr', function() gitsigns.reset_hunk() end)
    vim.keymap.set('n', '<Leader>hR', function() gitsigns.reset_buffer() end)

    vim.keymap.set('n', '<Leader>hp', function() gitsigns.preview_hunk() end)
    vim.keymap.set('n', '<Leader>hb', function() gitsigns.blame_line() end)

    vim.keymap.set('n', '<Leader>hd', function() gitsigns.diffthis() end)
    vim.keymap.set('n', '<Leader>hD', function() gitsigns.diffthis('@') end)
  end,
})
