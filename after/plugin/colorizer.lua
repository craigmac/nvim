local ok, colorizer = pcall(require, 'colorizer')
if not ok then return end

-- bonus: highlights NvimLightBlue (recognizes builtin colorscheme names)
-- NOTE: `:ColorizerToggle` to toggle
colorizer.setup({
  -- default is '*'. has way too many false posivitives, like netrw filenames, mentioning
  -- a colour like 'blue' in plain text/email/markdown/non-programming contexts
  filetypes = { 'css', 'html', 'toml', 'yaml', 'bash', 'sh' },
  user_default_options = {
    xterm = true, -- colors \e[38;5;128m - useful for bash/sh
  }
})
