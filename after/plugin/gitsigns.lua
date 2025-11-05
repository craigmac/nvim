local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return end

gitsigns.setup({
  -- show signs for already staged chunks? by default the signs look exactly
  -- the same so can't tell what has/hasn't been staged. with this disabled,
  -- you can't use gitsigns.reset_hunk(), use fugitive/lazygit
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

    -- switched from 'h<key>' to 'c<key>' to match ]c and [c. mnemonic: (c)hange
    vim.keymap.set({ 'x', 'n' }, '<Leader>cs', function() gitsigns.stage_hunk() end)
    vim.keymap.set('n', '<Leader>cS', function() gitsigns.stage_buffer() end)

    vim.keymap.set({ 'x', 'n' }, '<Leader>cr', function() gitsigns.reset_hunk() end)
    vim.keymap.set('n', '<Leader>cR', function() gitsigns.reset_buffer() end)

    vim.keymap.set('n', '<Leader>cp', function() gitsigns.preview_hunk() end)
    vim.keymap.set('n', '<Leader>cb', function() gitsigns.blame_line() end)

    vim.keymap.set('n', '<Leader>cd', function() gitsigns.diffthis() end)
    vim.keymap.set('n', '<Leader>cD', function() gitsigns.diffthis('@') end)
  end,
})
