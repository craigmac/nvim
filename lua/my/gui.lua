if vim.g.neovide then
  -- vim.notify('Neovide detected. Loading settings...')
  vim.cmd.tcd('~')
  -- padding is wasted space
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  -- no animations - was adding noticeable lag under Windows
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  -- fullscreen binding using typical F11
  vim.keymap.set('n', '<F11>', ':<C-u>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>')
  -- <C-[> is distinct from <Esc> in GUI
  vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')
end

local augroup = vim.api.nvim_create_augroup('my.augroup.uienter', {})
-- Fired when external UIs attach - this is main way nvim handles the idea of ginit.vim
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function(args)
    -- vim.notify('External UI has attached.')
  end,
  desc = 'Set config based on the GUI/External UI that has attached.',
  group = augroup
})


if vim.fn.has('gui_running') then
  local ns_id = vim.api.nvim_create_namespace('my.terminal.colours')
-- TODO: TermOpen, WinEnter autocmds to set this highlights for terminal buffers
-- vim.api.nvim_set_hl(ns_id, 'Terminal', { bg = '#141414', fg = '#bab7b6 })
-- vim.api.nvim_set_hl(ns_id, 'Visual' { bg = '#8db8e5', fg = '#000000' })
--
  -- use bright green cursor defined by Dimidium
  vim.api.nvim_set_hl(0, 'TermCursor', { bg = '#37e57b', fg = '#000000' })

  vim.g.terminal_color_0 = '#000000'
  vim.g.terminal_color_1 = '#cf494c'
  vim.g.terminal_color_2 = '#60b442'
  vim.g.terminal_color_3 = '#db9c11'
  vim.g.terminal_color_4 = '#0575d8'
  vim.g.terminal_color_5 = '#af5ed2'
  vim.g.terminal_color_6 = '#1db6bb'
  vim.g.terminal_color_7 = '#bab7b6'
  vim.g.terminal_color_8 = '#817e7e'
  vim.g.terminal_color_9 = '#ff643b'
  vim.g.terminal_color_10 = '#37e57b'
  vim.g.terminal_color_11 = '#fccd1a'
  vim.g.terminal_color_12 = '#688dfd'
  vim.g.terminal_color_13 = '#ed6fe9'
  vim.g.terminal_color_14 = '#32e0fb'
  vim.g.terminal_color_15 = '#dee3e4'
end
