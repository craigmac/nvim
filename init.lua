-- Neovim 0.6.0 configuration

require("my.options")
require("my.keymaps")
require("my.plugins")
require("my.colorscheme")
require("my.cmp")
require("my.lsp.init")
require("my.telescope")
require("my.treesitter")
require("my.comment")
require("my.gitsigns")
require("my.lualine")
require("my.autocommands")
require("my.fugitive")

-- TODO: stylua file for my nvim repo, what is the standard?
-- TODO: formatexpr, foldexpr for lsp servers
-- TODO: for null-ls create buflocal format command to call for each
-- TODO: custom lualine setup: no diff, absolute path, no icons, no EOL, shorter mode display
-- TODO: lazy load some packer stuff like Fugitive
-- TODO: look into coloring of liquid docs header final line tag: with underscore
-- getting highlighted wrong because presumably thinks that it is a valid heading?
-- TODO: Lfilter/Cfilter only use /{pat}/ for filename and message parts,
-- how can I get it to pickup 'error/warning' from the middle location part
-- TODO: get gf to work with Liquid syntax (some work done on this, not 100% working though)
-- TODO: create show_toc() for markdown bound to gO to populate Location list for that buffer,
-- see help ft implementation and adjust, because no md language server with support for this
