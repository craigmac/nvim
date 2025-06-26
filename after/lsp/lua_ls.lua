-- `:h lsp-config`
-- this config should override any settings from nvim-lspconfig, because user after/ folder
-- comes near last in the runtimepath, which is where vim.lsp.config() looks for configs to merge
return {
  root_markers = {
      {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
      },
      '.git',
    }
}
