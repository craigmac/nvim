if vim.g.neovide then
  vim.notify('Neovide detected. Loading settings...')
  vim.cmd.tcd('~/.config/nvim')
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
  -- if system doesn't have each of these fonts it will error out
  vim.o.guifont = 'Adwaita Mono,Cascadia Mono,Inconsolata:14'
  -- fullscreen binding using typical F11
  vim.keymap.set('n', '<F11>', ':<C-u>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>')
  -- <C-[> is distinct from <Esc> in GUI
  vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

  -- on Windows native
  if vim.fn.has('win64') == 1 then
    vim.o.shellslash = true
    vim.o.shell = 'pwsh -NoLogo'
    vim.o.shellcmdflag = '-NoProfile -ExecutionPolicy RemoteSigned -Command'
    vim.o.shellxquote = ''
    vim.o.shellpipe = '>%s 2>&1'
    vim.o.shellredir = '>%s 2>&1'
  end
end

local guis_augroup = vim.api.nvim_create_augroup('my.augroup.guis', {})

-- Fired when external UIs attach - this is main way nvim handles the idea of ginit.vim
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function(args)
    vim.notify('External UI has attached.')
  end,
  desc = 'Set config based on the GUI/External UI that has attached.',
  group = guis_augroup,
})

