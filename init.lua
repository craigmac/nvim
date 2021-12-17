-- neovim 0.6+ configuration

vim.cmd [[
set path=.,,**

]]

-- General
require "my.options"
require "my.plugins"
require "my.keymaps"
require "my.autocommand"
require "my.colorscheme"

-- Plugins
-- require "my.cmp"
-- require "my.comment"
-- require "my.gitsigns"
-- require "my.lsp"
-- require "my.lualine"
require "my.telescope"
-- require "my.toggleterm"

