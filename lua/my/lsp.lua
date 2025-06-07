-- Whenever an LSP server attaches successfully, run our callback to do setup.
-- Some mappings are done unconditionally in `$VIMRUNTIME/lua/vim/_defaults.lua`
-- file, and not repeated here.
--
-- gra      - code (a)ction
-- grr      - (r)eferences
-- grn      - re(n)ame
-- gri      - (i)mplementation
-- gO       - document symbol (like help buffer gO binding)
-- i_CTRL-S - (s)ignature
-- gd       - (d)efinition
-- gD       - (D)eclaraction
-- gy       - t(y)pe definition
-- g(       - incoming calls
-- g)       - outgoing calls
-- yoh      - toggle inlay hints
-- <leader>gO - workspace symbols
-- K        - popup docs window
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.attach', {}),
  callback = function(args)
    ---@type vim.lsp.Client|nil
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client == nil then return end

    vim.notify_once(string.format('%s %s attached.', '󰋼 ', client.name), vim.log.INFO)

    if client:supports_method('textDocument/completion') then
      -- too many odd edge cases with autotriggering and having to swap in/out nvim
      -- completeopt settings, just go full bore manual mode
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })
    end

    -- these quickly become annoying when on all the time so I set a vim-unimpaired style map
    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set('n', 'yoh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.notify(string.format('inlay hints are now: %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
      end, { buffer = true })
    end

    if client:supports_method('workspace/symbol') then
      vim.keymap.set('n', '<leader>gO', function()
        ---@diagnostic disable-next-line: undefined-field
        require('fzf-lua').lsp_live_workspace_symbols()
      end, { buffer = true })
    end

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
      vim.keymap.set(
        'n',
        'K',
        function() vim.lsp.buf.hover({ border = 'rounded', max_height = 10 }) end,
        { buffer = true }
      )
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
  end,
})

vim.diagnostic.config({
  float = {
    border = 'rounded',
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
