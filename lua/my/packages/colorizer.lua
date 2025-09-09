-- bonus: highlights NvimLightBlue (recognizes builtin colorscheme names)
require('colorizer').setup({
  -- default is '*'. has way too many false posivitives, like netrw filenames, mentioning
  -- a colour like 'blue' in plain text/email/markdown/non-programming contexts
  filetypes = { 'css', 'html', 'lua', 'vim', 'toml', 'yaml', 'bash', 'sh' },
  user_default_options = {
    xterm = true, -- colors \e[38;5;128m - useful for bash/sh
  }
})

vim.keymap.set('n', 'yoC', '<Cmd>ColorizerToggle<CR>')
