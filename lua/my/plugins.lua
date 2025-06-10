---@type vim.pack.Spec[]
local pkgs = {
  { source = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { source = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/HoNamDuong/hybrid.nvim',
  'https://github.com/mbbill/undotree',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/stevearc/quicker.nvim',
}

vim.pack.add(pkgs)

-- ~/.local/share/nvim/site/pack/core/opt/conform.nvim/
require('conform').setup({
  default_format_opts = {
    quiet = true,
    timeout_ms = 1000,
    lsp_format = 'never',
  },
  formatters_by_ft = {
    python = { 'black' },
    bash = { 'shfmt' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    -- yaml = { 'prettier' },
    -- json = { 'prettier' },
  },
})


-- ~/.local/share/nvim/site/pack/core/opt/fzf-lua/
local fzf = require('fzf-lua')

fzf.setup({
  defaults = { file_icons = false },
  fzf_colors = true, -- use colors from nvim
  keymap = {
    builtin = {
      true, -- override the defaults
      ['<M-p>'] = 'toggle-preview',
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
  winopts = { fullscreen = true },
})
vim.cmd([[FzfLua register_ui_select]])

vim.keymap.set('n', '<Leader>:', fzf.command_history)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader>/', fzf.live_grep_native)
vim.keymap.set('n', '<Leader><F1>', fzf.helptags)
vim.keymap.set('n', '<Leader>o', fzf.oldfiles)


-- ~/.local/share/nvim/site/pack/core/opt/gitsigns.nvim/
local gitsigns = require('gitsigns')
gitsigns.setup({
  on_attach = function(bufnr)
    vim.keymap.set('n', 'yog', gitsigns.toggle_signs)

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    vim.keymap.set('x', '<Leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v')}) end)
    vim.keymap.set('x', '<Leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v')}) end)

    vim.keymap.set('n', '<Leader>hs', gitsigns.stage_hunk)
    vim.keymap.set('n', '<Leader>hr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<Leader>hR', gitsigns.reset_buffer)
    vim.keymap.set('n', '<Leader>hp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<Leader>hb', gitsigns.blame_line)
    vim.keymap.set('n', '<Leader>hd', gitsigns.diffthis)
    -- diff with version of file in the commit referenced by '@' aka HEAD
    vim.keymap.set('n', '<Leader>hD', function() gitsigns.diffthis('@') end)
  end,
})


-- ~/.local/share/nvim/site/pack/core/opt/hybrid.nvim/
require('hybrid').setup({
  italics = { strings = false, emphasis = false, comments = false, folds = false, },
  overrides = function(highlights, colors)
    highlights['@markup.raw.block'] = { bg = colors.none }
    highlights['@markup.raw'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextError'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextWarn'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextInfo'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextHint'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextOk']   = { bg = colors.none }
  end,
})
require('hybrid').load()


-- ~/.local/share/nvim/site/pack/core/opt/nvim-lint/
local lint = require('lint')

lint.linters_by_ft = {
  lua = { 'selene' },
  bash = { 'shellcheck' },
  -- markdown = { 'vale' }, -- needs a vale.ini file setup
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('my.augroup.lint', { clear = true }),
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})

-- ~/.local/share/nvim/site/pack/core/opt/mason.nvim/
require('mason').setup({
  ui = {
    backdrop = 0, -- fully opaque, default 60
    width = 0.9, -- default 0.8
    height = 0.9, -- default 0.8
  },
})

-- ~/.local/share/nvim/site/pack/core/opt/nvim-surround/
require('nvim-surround').setup({})

-- ~/.local/share/nvim/site/pack/core/opt/quicker.nvim/
require('quicker').setup()
vim.keymap.set('n', '<Leader>q', function() require('quicker').toggle() end)
vim.keymap.set('n', '<Leader>l', function() require('quicker').toggle({ loclist = true }) end)

-- ~/.local/share/nvim/site/pack/core/opt/smart-splits.nvim/
local splits = require('smart-splits')
splits.setup()
vim.keymap.set('n', '<C-M-h>', splits.resize_left)
vim.keymap.set('n', '<C-M-j>', splits.resize_down)
vim.keymap.set('n', '<C-M-k>', splits.resize_up)
vim.keymap.set('n', '<C-M-l>', splits.resize_right)
vim.keymap.set('n', '<M-h>', splits.move_cursor_left)
vim.keymap.set('n', '<M-j>', splits.move_cursor_down)
vim.keymap.set('n', '<M-k>', splits.move_cursor_up)
vim.keymap.set('n', '<M-l>', splits.move_cursor_right)
vim.keymap.set('n', '<M-p>', splits.move_cursor_previous)

require('nvim-treesitter-textobjects').setup({
  move = { set_jumps = true },
  select = { lookahead = true }, -- jump forward like targets.vim
})

-- You can use the capture groups defined in `textobjects.scm`
local ts = require('nvim-treesitter-textobjects.select')

-- `i` and `a` textobjects for (f)unction and (c)lass
vim.keymap.set({ "x", "o" }, "af", function() ts.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "if", function() ts.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() ts.select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic", function() ts.select_textobject("@class.inner", "textobjects") end)

-- (a)round (s)cope textobject - this would override 's' default, 'sentence' textobject
vim.keymap.set({ "x", "o" }, "as", function() ts.select_textobject("@local.scope", "locals") end)

local mv = require('nvim-treesitter-textobjects.move')

-- redefine builtin ]m, ]], [m, et al. to use treesitter
vim.keymap.set({ "n", "x", "o" }, "]m", function() mv.goto_next_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[m", function() mv.goto_previous_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]M", function() mv.goto_next_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[M", function() mv.goto_previous_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]]", function() mv.goto_next_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[[", function() mv.goto_previous_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "][", function() mv.goto_next_end("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[]", function() mv.goto_previous_end("@class.outer", "textobjects") end)
