local lspconfig = require('lspconfig')

local lsp = {
  servers = {
    lua_ls = { },
  }
}


for server, settings in pairs(lsp.servers) do
  lspconfig[server].setup(settings)
end

