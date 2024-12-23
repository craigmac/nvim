vim.api.nvim_create_user_command("Cd", "tcd %:h", {})
vim.api.nvim_create_user_command('DiffOrig', function()
  vim.cmd[[
    leftabove vnew | vim.opt.bt = nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
    ]]
end, {})

vim.api.nvim_create_user_command('LspCapabilities', function()
  local client = vim.lsp.get_clients()[1]
  if client then
    vim.print(client.server_capabilities)
  else
    vim.print('No attached LSP servers found')
  end
end, {})

--[[
Error executing lua callback: /usr/local/share/nvim/runtime/lua/vim/lsp.lua:468: cmd: expected function|table, got nil
stack traceback:
        [C]: in function 'error'
        vim/shared.lua: in function 'validate'
        /usr/local/share/nvim/runtime/lua/vim/lsp.lua:468: in function '_resolve_config'
        /usr/local/share/nvim/runtime/lua/vim/lsp.lua:499: in function 'lsp_enable_callback'
        /usr/local/share/nvim/runtime/lua/vim/lsp.lua:553: in function </usr/local/share/nvim/runtime/lua/vim/lsp.lua:552>
        [C]: in function 'nvim_cmd'
        /usr/local/share/nvim/runtime/filetype.lua:36: in function </usr/local/share/nvim/runtime/filetype.lua:35>
        [C]: in function 'pcall'
        vim/shared.lua: in function <vim/shared.lua:0>
        [C]: in function '_with'
        /usr/local/share/nvim/runtime/filetype.lua:35: in function </usr/local/share/nvim/runtime/filetype.lua:10>
stack traceback:
        [C]: in function '_with'
        /usr/local/share/nvim/runtime/filetype.lua:35: in function </usr/local/share/nvim/runtime/filetype.lua:10>
--]]
