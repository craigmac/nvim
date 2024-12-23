-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
-- settings for all luals servers, folder/project specifics
-- should go in .luarc.json at repo root
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.luacheckrc', '.git' },
  -- https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
