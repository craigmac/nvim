step 11 in `:h startup` - exact tag is `:h load-plugins`

* loading of this directory is done after `init.lua`
* no loading is done if one of the following is true:
  * `vim.o.loadplugins = false` was set in `init.lua`
  * nvim was started with `--noplugin`, `--clean`, or `-u NONE` arguments
* after this directory is loaded, the next startup step is loading all
  `pack/*/start/*/plugin/` directories found in `:h 'packpath`
* HOWEVER, if using `vim.pack.add()` in `init.lua` by default those packages are
  managed only in `opt/` directory but are loaded immediately after install, and
  so anything added by `vim.pack.add()` is added and then immediately `packadd <foo>`
  is ran so that you can immediately use the package:

  Locations where `vim.pack.add()` stores packages:

  Windows: ~/AppData/Local/nvim-data/site/pack/core/opt/
  Linux:   ~/.local/share/nvim/site/pack/core/opt/

  Confused, yet?

so....if we `vim.pack.add('https://github.com/ibhagwan/fzf-lua')` in `init.lua`
we are fine to do `local fzf = require('fzf-lua')` in `plugin/fzf-lua.lua`.

