# TODO/IDEA/BUG/HACK collection

## TODO

- Remove "how to remove mouse" from menu
- determine &shellpipe for Windows pwsh.exe PowerShell 7.5.x

## GUIs

- right click menu stuff
- shortcut gvim to launch it from cmd.exe/wt.exe

## BUGS

- Fugitive* autocmds are not working, saying they are 'Invalid Event'
- FileType autocmd with netrw buggy bc it's autoload functions load later than user
  init.lua, will `after/ftplugin/netrw.lua` even solve the highlight bug? bc it's called
  for every invoction of listing function, it would overwrite anything I set up?
- maybe use a hack with event SourcePost and match on that file?
- in netrw `s:PerformList()` calls `setlocal ft=netrw` which retriggers default syntax
```text
$VIMRUNTIME/pack/dist/opt/netrw/autoload/netrw.vim:9097
```

## IDEAS

- Mouse right back button for <C-o>? how
- Look again at my gm right-menu plugin and integrate it instead as an optional
  plugin that adds lsp context stuff.
- add nonumber nolist in location list and quickfix list, and turn off cursorline too
- can we get smart-splits.nvim to work in VSCode via vscode-neovim plugin

