-- Some mappings are done unconditionally in `$VIMRUNTIME/lua/vim/_defaults.lua`:
-- gra      - code (a)ction
-- grr      - (r)eferences
-- grn      - re(n)ame
-- gri      - (i)mplementation
-- gO       - document symbol (like help buffer gO binding)
-- i_CTRL-S - (s)ignature
-- an       -  expand selection, (a)dd (n)ode, using vim.lsp.buf.selection_range()
-- in       -  shrink selection, (i)n (n)ode, both can take a count too, like: 3van
-- <Tab>    - snippet jump forward if snippet active
-- <S-Tab>  - snippet jump backward if snippet active
--
-- set here:
-- gd       - (d)efinition
-- gD       - (D)eclaraction
-- gy       - t(y)pe definition
-- g(       - incoming calls
-- g)       - outgoing calls
-- yoh      - toggle inlay hints
-- <leader>gO - workspace symbols, like gO is for buffer symbols
-- K        - popup docs window


---@param ev any Event data
local function lspattach_cb (ev)
  ---@type vim.lsp.Client|nil
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client == nil then return end

  vim.notify_once(string.format('%s %s attached.', '󰋼 ', client.name), vim.log.INFO)

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })

  -- these quickly become annoying when on all the time so I set a vim-unimpaired style map
  if client:supports_method('textDocument/inlayHint') then
    vim.keymap.set('n', 'yoh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify(string.format('Show inlay hints set to %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
    end, { buffer = true })
  end

  if client:supports_method('workspace/symbol') then
    vim.keymap.set('n', '<leader>gO', function()
      ---@diagnostic disable-next-line: undefined-field
      require('fzf-lua').lsp_live_workspace_symbols()
    end, { buffer = true })
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

  if client:supports_method('textDocument/hover') then
    vim.keymap.set( 'n', 'K',
    function() vim.lsp.buf.hover({ border = 'rounded', max_height = 10 }) end,
    { buffer = true })
  end

  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    if vim.wo[win].foldmethod == 'marker' then
      -- if user has fdm set to this, they want specific folds in this buffer so bail
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
    source = true, -- show where diagnostic comes from
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
          -- TODO: inline this using vim.fn.glob(lazypath, '*')
          runtime_files,
        },
        checkThirdParty = false,
      },
    },
  }
}

-- merge-in plugin paths - we can't use '*' wildchar in .luarc.json, lua_ls doesn't support it
-- extends any config chain found
vim.lsp.config('lua_ls', luals_config)

vim.lsp.enable({
  'bashls',
  'jsonls',
  'lua_ls',
  'taplo',
  'vimls',
  'vale_ls',
  'yamlls',
  'marksman',
})
