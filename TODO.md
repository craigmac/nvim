# TODO/IDEA/BUG/HACK collection

## TODO


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

- , should always be left/down and ; should always be up/right:
    - maybe need to register a global, no `v:` variable storing whether last was f,F,t or T
    because they are not operators, so they are not in `v:operator`
- Mouse right back button for <C-o>? how
- Look again at my gm right-menu plugin and integrate it instead as an optional
  plugin that adds lsp context stuff.
- add nonumber nolist in location list and quickfix list, and turn off cursorline too
- can we get smart-splits.nvim to work in VSCode via vscode-neovim plugin

- turn on relative numbers in these situations (where they are useful):
:au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
:au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
:au WinEnter,WinLeave * let &l:rnu = mode() =~# '^[vV\x16]'
- progress messages autocmd:
    vim.api.nvim_create_autocmd('Progress', {
            pattern={"term"},
            callback = function(ev)
            print(string.format('event fired: %s', vim.inspect(ev)))
            end
            })
local id = vim.api.nvim_echo({{'searching...'}}, true,
        {kind='progress', status='running', percent=10, title="term"})
vim.api.nvim_echo({{'searching'}}, true,
        {id = id, kind='progress', status='running', percent=50, title="term"})
vim.api.nvim_echo({{'done'}}, true,
        {id = id, kind='progress', status='success', percent=100, title="term"})

- Termresponse autocmd stuff:

-- Query the terminal palette for the RGB value of color 1
-- (red) using OSC 4
vim.api.nvim_create_autocmd('TermResponse', {
        once = true,
        callback = function(args)
        local resp = args.data.sequence
        local r, g, b = resp:match("\027%]4;1;rgb:(%w+)/(%w+)/(%w+)")
        end,
        })
vim.api.nvim_ui_send("\027]4;1;?\027\\")
