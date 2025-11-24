Files here are auto-sourced like after vimrc/init.lua/init.vim, BUT before
packages in &packpath, so checks/guards like `if g:loaded_fugitive == 1`
won't work properly if used in here because it hasn't been loaded yet.

Useful for setting variables that a plugin looks for during it's setup, like
g:tmux_* variables must be set before vim-tmux-navigator/plugin/*.vim loads or
it will setup it's own default keybindings using <C-h/j/k/l>.

