-- Some mappings are done unconditionally in `$VIMRUNTIME/lua/vim/_defaults.lua`: see `:h grr`
--
-- set here:
-- <C-s>    - show code signature in insert mode
-- K        - like typical K but for lsp
-- gra      - (r)eveal code (a)tions
-- grn      - (r)e(n)ame
-- grr      - (r)efe(r)ences
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
local M = {}

function M.my_lsp_detach(args)
  vim.api.nvim_clear_autocmds({
    event = { 'BufWritePre', 'CursorHold', 'CursorMoved' },
    buffer = args.buf,
  })
end

function M.my_lsp_attach(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  vim.notify_once(string.format('%s attached.', client.name), vim.log.INFO)

  vim.keymap.set('i', '<C-s>', vim.lsp.buf.code_signature, { buffer = true })
  vim.keymap.set('n', 'grr', vim.lsp.buf.references, { buffer = true })
  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = true })
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = true })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })
  vim.keymap.set('n', 'g(', vim.lsp.buf.incoming_calls, { buffer = true })
  vim.keymap.set('n', 'g)', vim.lsp.buf.outgoing_calls, { buffer = true })
  vim.keymap.set('n', 'grO', function() require('fzf-lua').lsp_live_workspace_symbols() end, { buffer = true })
  vim.keymap.set('n', '<Leader>gq', vim.lsp.buf.format, { buffer = true })

  vim.keymap.set('n', 'yoh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    vim.notify(string.format('Show inlay hints set to %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
  end, { buffer = true })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = args.buf,
    callback = function()
      vim.lsp.buf.format({
        bufnr = args.buf,
        id = client.id,
      })
    end,
  })

  if client:supports_method('textDocument/documentHighlight') then
    vim.cmd([[
    autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]])
  end

  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    -- bail if we detect explicitly set foldmarkers
    if vim.wo[win].foldmethod == 'marker' then return end
    vim.wo[win][0].foldmethod = 'expr'
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end
end

-- vim.lsp.enable|config(), LspAttach|Detach unavailable until nvim 0.11
--
-- local servers = { 'lua_ls', 'bash_ls', 'clangd' }
-- for _, lsp in ipairs(servers) do
--   on_attach = my_lsp_attach,
--   on_detach = my_lsp_detach,
-- end

