local M = {}

---Creates a new 'LSP' popup menu if not existing already and disables all the items
---so each menu item can be selectively enabled dynamically based on what any lsp server
---actually supports
function M.build_lsp_popup_menu()
  if not vim.tbl_isempty(vim.fn.menu_info('LSP')) then return end

  vim.cmd.nnoremenu([[LSP.Go\ to\ Definition <Cmd>lua vim.lsp.buf.definition()<CR>]])
  vim.cmd.nnoremenu([[LSP.Go\ to\ Declaration <Cmd>lua vim.lsp.buf.declaration()<CR>]])
  vim.cmd.nnoremenu([[LSP.Go\ to\ Implementation <Cmd>lua vim.lsp.buf.implementation()<CR>]])
  vim.cmd.nnoremenu([[LSP.Go\ to\ Type\ Definition <Cmd>lua vim.lsp.buf.type_definition()<CR>]])
  vim.cmd.nnoremenu([[LSP.Go\ to\ References <Cmd>lua vim.lsp.buf.references()<CR>]])
  vim.cmd.nnoremenu([[LSP.Rename\ Symbol <Cmd>lua vim.lsp.buf.rename()<CR>]])
  vim.cmd.nnoremenu([[LSP.Show\ Code\ Actions <Cmd>lua vim.lsp.buf.code_action()<CR>]])
  vim.cmd.nnoremenu([[LSP.Show\ Document\ Symbols <Cmd>lua vim.lsp.buf.document_symbol()<CR>]])
  vim.cmd.nnoremenu([[LSP.Show\ Workspace\ Symbols <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>]])
  vim.cmd.nnoremenu([[LSP.Show\ Incoming\ Calls <Cmd>lua vim.lsp.buf.incoming_calls()<CR>]])
  vim.cmd.nnoremenu([[LSP.Show\ Outgoing\ Calls <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>]])
  vim.cmd.nnoremenu([[LSP.Format\ Buffer <Cmd>lua vim.lsp.buf.format()<CR>]])
  vim.cmd.nnoremenu(
    [[LSP.Toggle\ Inlay\ Hints <Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>]])

  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Go\\ to\\ Definition' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Go\\ to\\ Declaration' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Go\\ to\\ Implementation' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Go\\ to\\ Type\\ Definition' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Go\\ to\\ References' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Rename\\ Symbol' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Show\\ Code\\ Actions' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Show\\ Document\\ Symbols' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Show\\ Workspace\\ Symbols' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Show\\ Incoming\\ Calls' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Show\\ Outgoing\\ Calls' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Toggle\\ Inlay\\ Hints' } })
  vim.cmd.nunmenu({ args = { 'disable', 'LSP.Format\\ Buffer' } })
end

---@param bufnr? number Buffer id to query for attached clients
function M.lsp_popup_menu(bufnr)
  ---@type vim.lsp.Client[]|{}
  local clients = vim.lsp.get_clients({ bufnr = bufnr or 0 })
  -- no active lsp connections, bail
  if vim.tbl_isempty(clients) then
    vim.notify('Menu unavailable - no lsp clients attached')
    return
  end

  M.build_lsp_popup_menu()

  -- TODO: arbitrarily picking first one, what if there's > 1 and they both support the method?
  local client = clients[1]

  if client:supports_method('textDocument/definition') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Go\\ to\\ Definition' } })
  end

  if client:supports_method('textDocument/declaration') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Go\\ to\\ Declaration' } })
  end

  if client:supports_method('textDocument/implementation') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Go\\ to\\ Implementation' } })
  end

  if client:supports_method('textDocument/typeDefinition') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Go\\ to\\ Type\\ Definition' } })
  end

  if client:supports_method('textDocument/references') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Go\\ to\\ References' } })
  end

  if client:supports_method('textDocument/codeAction') then
    vim.cmd.aunmenu({ args = { 'enable', 'LSP.Show\\ Code\\ Actions' } })
  end


  vim.cmd.popup('LSP')
end

return M
