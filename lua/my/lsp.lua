-- Some mappings are done unconditionally in `$VIMRUNTIME/lua/vim/_defaults.lua`: see `:h grr`
--
-- set here:
-- gd       - (d)efinition
-- gD       - (D)eclaraction
-- gy       - t(y)pe definition
-- g(       - incoming calls
-- g)       - outgoing calls
-- yoh      - toggle inlay hints
-- grO      - workspace symbols, like gO is for buffer symbols but using gr-prefix for lsp stuff

---@param ev any Event data
local function lspattach_cb (ev)
  ---@type vim.lsp.Client|nil
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client == nil then return end

  vim.notify_once(string.format('%s %s attached.', '󰋼 ', client.name), vim.log.INFO)

  -- supported large majority of the time, no need to wrap these
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })

  if client:supports_method('textDocument/documentColor') then
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
  end

  -- highlight hex colors like colorizer!
  if client:supports_method('textDocument/highlight') then
   vim.lsp.document_color.enable(true, ev.buf)
 end

  if client:supports_method('textDocument/typeDefinition') then
    vim.keymap.set('n', 'gy', function() vim.lsp.buf.type_definition() end, { buffer = true })
  end

  if client:supports_method('callHierarchy/incomingCalls') then
    vim.keymap.set('n', 'g(', function() vim.lsp.buf.incoming_calls() end, { buffer = true })
  end

  if client:supports_method('callHierarchy/outgoingCalls') then
    vim.keymap.set('n', 'g)', function() vim.lsp.buf.outgoing_calls() end, { buffer = true })
  end

  -- these quickly become annoying when on all the time so I set a vim-unimpaired style map
  if client:supports_method('textDocument/inlayHint') then
    vim.keymap.set('n', 'yoh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify(string.format('Show inlay hints set to %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
    end, { buffer = true })
  end

  if client:supports_method('workspace/symbol') then
    vim.keymap.set('n', 'grO', function() require('fzf-lua').lsp_live_workspace_symbols() end, { buffer = true })
  end

  if client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({
          bufnr = ev.buf,
          id = client.id,
          filter = function(c) return c.name ~= 'lua_ls' end,
        })
      end,
    })
  end

  if client:supports_method('textDocument/documentHighlight') then
    vim.cmd([[
    autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]])
  end

  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    if vim.wo[win].foldmethod == 'marker' then
      -- if user has fdm set to this, it means they want specific folds in this buffer, so bail
      return
    end
    vim.wo[win][0].foldmethod = 'expr'
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.attach', {}),
  callback = lspattach_cb,
})

vim.diagnostic.config({
  float = {
    border = 'single',
    header = 'Diagnostics',
    severity_sort = true,
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN]  = '󰀪 ',
      [vim.diagnostic.severity.INFO]  = '󰋽 ',
      [vim.diagnostic.severity.HINT]  = '󰌶 ',
    },
  },
  severity_sort = true,
  virtual_text = false,
})

--[[ my old way
-- HACK: https://github.com/neovim/nvim-lspconfig/issues/3189
local runtime_files = vim.api.nvim_get_runtime_file('', true)
for k, v in ipairs(runtime_files) do
  if v == '/home/craig/.config/nvim/after' or v == '/home/craig/.config/nvim' then table.remove(runtime_files, k) end
end

---@type vim.lsp.Config
local luals_config = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- find modules the neovim way - default otherwise is `{ '?.lua', '?/init.lua' }`
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          -- TODO: inline this using vim.fn.glob(stdpath('data')..., '*')
          runtime_files,
        },
        checkThirdParty = false,
      },
    },
  }
}
vim.lsp.config('lua_ls', luals_config)
--]]

---@type vim.lsp.Config
local lua_ls_config = {
  root_markers = {
    { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' }, '.git'
  },
  on_init = function(client)
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}

--[[[ from nvim-lspconfig docs:
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          }
        })
      end,
      settings = { Lua = {} }
})
--]]

vim.lsp.config('lua_ls', lua_ls_config)
vim.lsp.enable({ 'lua_ls' })

-- vim.lsp.enable({
  -- 'lua_ls',
  -- 'bashls',
  -- 'jsonls',
  -- 'taplo',
  -- 'vimls',
  -- 'vale_ls',
  -- 'yamlls',
  -- 'marksman',
-- })
