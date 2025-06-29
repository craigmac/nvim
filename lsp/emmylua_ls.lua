--- https://github.com/EmmyLuaLs/emmylua-analyzer-rust
--- install rust with https://rustup.rs, then
--- `cargo install emmylua_ls`
return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = {
    {
      '.luarc.json',
      '.emmyrc.json',
      '.luacheckrc',
      'stylua.toml',
      '.stylua.toml',
      'selene.toml',
      'selene.yml',
    },
    '.git',
  },
  workspace_required = false,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      strict = {
        typeCall = true,
        arrayIndex = true,
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
