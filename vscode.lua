-- init file for 'VSCode Neovim' extension in VS Code
--
-- NOTES:
-- * multiple cursors bindings: `ma/mA` and `mi/mI`
-- * advanced multiple cursor features if that's not enough at:
--   https://github.com/vscode-neovim/vscode-multi-cursor.nvim
-- * commands like `:e` in scripts/keybinds won't work. Rebind them
--   to instead call VSCode commands via APIiwth `require('vscode').call()`
-- * 3 types/places of keybindings:
--   1. Nvim bindings: defined by the installed extension's vim script files, or
--      the user's init.vim/init.lua file.
--   2. VSCode bindings: defined in extension's `package.json` or user's `keybindings.json`
--      file. Allows interaction with Code's builtin-features
--   3. VSCode passthrough bindings: same places as above, but bindings defined this way simply
--      pass the keypress through to Neovim. Used to handle keys in extension that would
--      otherwise be handled by Code itself if not overridden.

local vscode = require('vscode')

-- use vscode's notification feature as default notify function
vim.notify = vscode.notify
