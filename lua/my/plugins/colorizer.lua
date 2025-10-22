return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    -- default is '*'. has way too many false posivitives, like netrw filenames, mentioning
    -- a colour like 'blue' in plain text/email/markdown/non-programming contexts
    filetypes = { 'css', 'html', 'lua', 'vim', 'toml', 'yaml', 'bash', 'sh' },
    user_default_options = {
      xterm = true, -- colors \e[38;5;128m - useful for bash/sh
    }
  }
}
