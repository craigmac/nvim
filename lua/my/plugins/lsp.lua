-- Some mappings are done unconditionally in `$VIMRUNTIME/lua/vim/_defaults.lua`: see `:h grr`
--
-- set here:
-- gd       - (d)efinition
-- gD       - (D)eclaraction
-- g(       - incoming calls
-- g)       - outgoing calls
-- yoh      - toggle inlay hints
-- grO      - workspace symbols, like gO is for buffer symbols but using gr-prefix for lsp stuff
-- <Leader>gq - like gq to format, but for whole buffer
--
-- See what attached lsp client supports:
-- :lua =vim.lsp.get_clients()[1].server_capabilities

local function lspdetach_cb(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  -- Remove the autocommand to format the buffer on save, if it exists
  if client:supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({
      event = 'BufWritePre',
      buffer = args.buf,
    })
  end
end

local function lspattach_cb(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  -- vim.notify_once(string.format('%s attached.', client.name), vim.log.INFO)

  if client:supports_method('textDocument/definition') then
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
  end

  if client:supports_method('textDocument/declaration') then
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })
  end

  if client:supports_method('textDocument/completion') then
    -- autotrigger doesn't work well with nvim default completeopt, unless 'noselect' is added
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    vim.keymap.set('i', '<C-i>', function() vim.lsp.completion.get() end)
  end

  if client:supports_method('textDocument/prepareCallHierarchy') then
    if client:supports_method('callHierarchy/incomingCalls') then
      vim.keymap.set('n', 'g(', function() vim.lsp.buf.incoming_calls() end, { buffer = true })
    end
    if client:supports_method('callHierarchy/outgoingCalls') then
      vim.keymap.set('n', 'g)', function() vim.lsp.buf.outgoing_calls() end, { buffer = true })
    end
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

  -- Usually not needed if server supports "textDocument/willSaveWaitUntil"
  if
      not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting')
  then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({
          bufnr = args.buf,
          id = client.id,
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

  if client:supports_method('textDocument/formatting') then
    vim.keymap.set('n', '<Leader>gq', function() vim.lsp.buf.format() end, { buffer = true })
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

-- setup our attach/detach custom callbacks to run on LspAttach|Detach events
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.attach', {}),
  callback = lspattach_cb,
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('my.lsp.detach', {}),
  callback = lspdetach_cb,
})

vim.diagnostic.config({
  float = {
    border = 'single',
    header = 'Diagnostics',
    severity_sort = true,
    source = true,
  },
  severity_sort = true,
  virtual_text = false,
})

---@type vim.lsp.Config
local lua_lsp_config = {
  on_init = function(client)
    -- do nothing if not in a proper workspace (no marker, even .git, found)
    if not client.workspace_folders then return end

    -- do nothing if workspace isn't the user's neovim config directory
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath('config') then return end

    -- workspace is in neovim user config directory, so we extend lsp context to
    -- include nvim runtime paths. see `:set rtp?` to see locations in scope
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      workspace = {
        -- BUG: https://github.com/neovim/nvim-lspconfig/issues/3189
        -- solution: filter out stdpath('config') and it's 'after' directory manually
        library = vim.tbl_filter(function(d)
          return not d:match(vim.fn.stdpath('config') .. '/?a?f?t?e?r?')
        end, vim.api.nvim_get_runtime_file('', true))
      },
    })
  end,
}

--merge our extra config, in to existing `lsp\emmylua_ls.lua`
vim.lsp.config('emmylua_ls', lua_lsp_config)

-- setup auto start/stopping of these lsp servers
vim.lsp.enable({
  'emmylua_ls'
})
