-- global variables for builtin packages and options
My = {} --  reserve a global table/namespace, view with `:=My`

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- stops these $VIMRUNTIME/plugin files from loading completely (tiny impact on startup)
vim.g.loaded_gzip = 'any string should fail exists() test'
vim.g.loaded_zipPlugin = 'keep your bible quotes to yourself'
vim.g.loaded_remote_plugins = 'never use this'
vim.g.loaded_tarPlugin = 'nope I never browse .tar files'
vim.g.loaded_tutor_mode_plugin = 'no more :Tutor'
