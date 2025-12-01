" user overrides for $VIMRUNTIME/ftplugin/lua.vim
" nvim also has $VIMRUNTIME/ftplugin/lua.lua which sets up treesitter etc.

" neither vim ftplugin nor nvim ftplugin for lua does not set these
" .editorconfig is preferred - use these otherwise (from nvim's stylua.toml)
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=-1
setlocal textwidth=100

let b:undo_ftplugin ..= " | setl et< sw< sts< tw<"
