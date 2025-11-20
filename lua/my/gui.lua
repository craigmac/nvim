if vim.g.neovide then
  vim.cmd.tcd('~')
  -- padding is wasted space
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  -- no animations
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  -- fullscreen binding using typical F11
  vim.keymap.set('n', '<F11>', ':<C-u>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>')
  -- <C-[> is distinct from <Esc> in GUI
  vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')
end

-- Fired when external UIs attach - this is nvim equivalent to vim's `gvimrc` concept
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function(_args) end,
  desc = 'Set config based on the GUI/External UI that has attached.',
  group = vim.api.nvim_create_augroup('my.augroup.uienter', {}),
})
