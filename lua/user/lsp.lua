-- reads configs for same named server from lsp/*.lua
-- and sets up filetype autocmds for starting the server
vim.lsp.enable('luals')

-- `:=vim.lsp.get_clients()[1].server_capabilities` to view what server can do
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    -- BUG: buggy with luals, just inserts stuff automatically, try with nvim-playground rtp
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end

    -- repurpose default nvim lsp bindings to use fzf-lua
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', 'gra', '<Cmd>FzfLua lsp_code_actions previewer=false<CR>',
        { buffer = true })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', '<Cmd>FzfLua lsp_definitions<CR>', { buffer = true })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', '<Cmd>FzfLua lsp_declarations<CR>', { buffer = true })
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gri', '<Cmd>FzfLua lsp_implementations<CR>', { buffer = true })
    end

    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gy', '<Cmd>FzfLua lsp_typedefs<CR>', { buffer = true })
    end

    if client:supports_method('textDocument/documentSymbol') then
      vim.keymap.set('n', 'gO', '<Cmd>FzfLua lsp_document_symbols previewer=false<CR>',
        { buffer = true })
    end
    if client:supports_method('textDocument/foldingRange') then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    if client:supports_method('callHierarchy/incomingCalls') then
      vim.keymap.set('n', 'g(', '<Cmd>FzfLua lsp_incoming_calls<CR>', { buffer = true })
    end

    if client:supports_method('callHierarchy/outgoingCalls') then
      vim.keymap.set('n', 'g)', '<Cmd>FzfLua lsp_outgoing_calls<CR>', { buffer = true })
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set("n", "yoh",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { buffer = true })
    end

    if client:supports_method('workspace/symbol') then
      vim.keymap.set("n", "<leader>gO", "<Cmd>FzfLua lsp_live_workspace_symbols<CR>",
        { buffer = true })
    end

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end

    if client:supports_method('textDocument/highlight') then
      vim.cmd([[
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      ]])
    end

    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({ border = 'rounded', max_height = 10 })
      end, { buffer = true })
    end
  end,
})
