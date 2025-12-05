if vim.fn.has('gui_running') == 1 then
  -- options/settings for ALL GUIs, regardless of OS
  vim.cmd.tcd(vim.fn.stdpath('config'))

  -- <C-[> is distinct from <Esc> in GUI
  vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

  -- options/settings for specific GUIs, separated into Windows and macOS/Linux
  if vim.fn.has('win32') == 1 then
    -- Windows box, 32 means either 32 or 64 bit executable
    vim.o.guifont = 'Cascadia Mono:h14'
  else -- macOS/Linux
    vim.o.guifont = 'Adwaita Mono:h14'
  end

  -- options/settings for Neovide
  if vim.g.neovide then
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
  end
end
