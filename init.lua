-- nvim nightly config

-- reserve a namespace on the global table
_G.my = {}

require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')

require('plugins.init')

-- ⚠ experimental ⚠
vim.loader.enable()

-- ⚠ experimental ⚠
require('vim._extui').enable({ enable = true, msg = { target = 'msg', timeout = 4000 }})

-- TODO: lua_ls don't diagnose library files when opened
-- TODO: emmylua_ls instead?
-- TODO: findprg and leader f/b mappings
-- TODO: yoz toggle foldenable
-- TODO: yov virtualedit+=all -=all toggle
-- TODO: formatoptions+=rno1l/
-- TODO: , always goes left, ; always goes right, and never think about it again
-- TODO: nnoremap gV `[v`]
-- TODO: insert mode c-r paste should be literal paste, so no formatting as it's pasted! there's a PR for this
-- TODO: add ie/ae text object for (e)ntire buffer
-- BUG: extui bug? q: window thing
-- BUG: completeopt fuzzy and :G<tab> not prioritizing capital match with ignorecase+smartcase on
-- IDEA: auto iabbrev plugin when z= fix chosen add new iabbrev for it
-- TODO: try justinmk config
-- IDEA: vim patch to make stl truncation character '<' changeable with fillchar?
-- TODO: nvim-news plugin
-- TODO: justinmk/nvim-repl and friends for plugin dev
-- TODO: tabline: define User0-9 highlights too matching hybrid.nvim colors (API for it?)
-- TODO: tabline: saved reddit post about it!
-- TODO: tabline: show tabpage no. and bind alt/leader 1-N to them
-- TODO: 
