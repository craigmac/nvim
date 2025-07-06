return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    {
      '.luarc.json',
      '.luarc.jsonc',
      'stylua.toml',
      '.stylua.toml',
      'selene.toml',
      'selene.yml'
    },
    '.git'
  },
  -- settings we want to apply globally to all workspaces
  settings = {
    Lua = {
      diagnostics = {
        -- using e.g., 'vim' for a global is fine
        disable = { 'lowercase-global' },
        -- variables that are known globals
        globals = { 'vim', 'it' },
        -- never diagnose ignored files. default is "Opened" (diagnose them if opened)
        ignoredFiles = "Disable",
        -- don't report `_` as unused in `local foo, _ = bar()`
        unusedLocalExclude = { '_*' },
        -- never diagnose library files. default is "Opened"
        libraryFiles = "Disable"
      },
      doc = {
        -- table fields matching these are 'private' (not shown in autocomplete)
        privateName = { '__.*', '_.*' }
      },
      format = {
        enable = true,
        -- .editorconfig in the workspace takes priority over this
        defaultConfig = {
          call_arg_parentheses = 'always',
          continuation_indent = '2',
          -- unix eol
          end_of_line = 'LF',
          indent_style = 'space',
          indent_size = '2',
          insert_final_newline = true,
          max_line_length = '120',
          quote_style = 'single',
        }
      },
      hint = {
        enable = true,
        -- show what type will be applied in var assignments
        setType = true
      },
      runtime = {
        version = 'LuaJIT',
        -- defines how to look in workspace folders on `require()` call
        -- adjusted for nvim-style, default is `{ '?.lua', '?/init.lua' }`
        path = {
          'lua/?.lua',
          'lua/?/init.lua'
        },
        -- only search first level of dirs, i.e., not `<workspace>/**/myFile/init.lua`
        -- if `runtime.path = { '?/init.lua' }`. will require very precise
        -- and correct `runtime.path` values. default is `false`
        pathStrict = false,
      },
      semantic = {
        -- default false: colouring of keywords, literals, and operators?
        -- only need this is editor unable to highlight lua syntax/no treesitter
        keyword = false,
        -- default true: colouring of vars, fields, and params?
        variable = true,
      },
      type = {
        -- default false. strict checking of table shape
        checkTableShape = true,
        -- default false. infer type from fn call sites if param type is not annotated
        inferParamType = true,
        -- default 10. how many fields max to analyze during type inference
        inferTableSize = 20,
        -- https://luals.github.io/wiki/settings/#typeweaknilcheck
        weakNilCheck = true,
        -- https://luals.github.io/wiki/settings/#typeweakunioncheck
        weakUnionCheck = true,
      },
      workspace = {
        checkThirdParty = false
      }
    },
  },
}
