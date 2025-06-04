-- nvim nightly config

require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')

require('my.package-manager')
require('my.lsp')

-- experimental
-- vim.loader.enable() -- issue with long filenames causing crashes
require('vim._extui').enable({})

-- TODO: fix gitsigns mappings
-- TODO: how to register blink.cmp capabilities - LspOnAttach?
-- TODO: lspconfig load time, when to load it?
-- TODO: mason.nvim ensure installed stuff
-- TODO: setup blink.cmp keymaps
-- TODO: is mason-lspconfig even needed anymore??
-- TODO: PR to mason for emmylua_check
-- TODO: fix fzf-lua leader f et al keymaps from vim script to lua and
-- not respecting ui settings in opt, maybe because used vim script cmd?
