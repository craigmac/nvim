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
--
-- See what attached lsp client supports:
-- :lua =vim.lsp.get_clients()[1].server_capabilities

local function lspattach_cb(args)
  ---@type vim.lsp.Client
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  vim.notify_once(string.format('%s %s attached.', '󰋼 ', client.name), vim.log.INFO)

  -- supported large majority of the time, no need to wrap these
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })

  if client:supports_method('textDocument/documentColor') then
    -- does not work well with nvim default completeopt, unless 'noselect' is added
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    vim.keymap.set('i', '<C-i>', function() vim.lsp.completion.get() end)
  end

  -- highlight hex colors like colorizer!
  if client:supports_method('textDocument/documentHighlight') then vim.lsp.document_color.enable(true, args.buf) end

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

  -- if
  --   not client:supports_method('textDocument/willSaveWaitUntil')
  --   and client:supports_method('textDocument/formatting')
  -- then
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     buffer = args.buf,
  --     callback = function()
  --       vim.lsp.buf.format({
  --         bufnr = args.buf,
  --         id = client.id,
  --         -- filter = function(c) return c.name ~= 'emmylua_ls' end,
  --       })
  --     end,
  --   })
  -- end

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
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  severity_sort = true,
  virtual_text = false,
})

---@type vim.lsp.Config
local emmylua_ls_config = {
  on_init = function(client)
    -- do nothing if not in a proper workspace (no marker, even .git, found)
    if not client.workspace_folders then return end

    local path = client.workspace_folders[1].name
    -- do nothing if workspace isn't user neovim config directory
    if path ~= vim.fn.stdpath('config') then return end

    -- add nvim rtp paths to installed plugins and builtin $VIMRUNTIME/lua
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      workspace = {
        -- BUG: https://github.com/neovim/nvim-lspconfig/issues/3189
        library = vim.api.nvim_get_runtime_file('', true),
      },
    })
  end,
}
-- merge the `on_init()` method to the config
vim.lsp.config('emmylua_ls', emmylua_ls_config)

vim.lsp.enable({
  'emmylua_ls',
  'vscode-json-language-server',
  -- 'taplo',
  -- 'vimls',
  -- 'yamlls',
})
