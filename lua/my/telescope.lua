local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    -- preview = false
    -- I don't want shortened paths because I'm always picking several files of same name
    -- from folders several layers deep, and I need that information
    path_display = { "absolute" },
    mappings = {
      i = {
        -- I don't want a Normal mode, just close it instead
        -- of going to Normal mode and the having to Esc again
        ["<esc>"] = actions.close,
        ["<M-p>"] = require'telescope.actions.layout'.toggle_preview
      },
    },

  },
  pickers = {
    -- TODO: create replacement for builtins like :buffers, :jumps etc.
    -- using theme=ivy
    git_files = {
      theme = "dropdown",
      previewer = false,
      prompt_title = false
    },
    find_files = {
      theme = "dropdown",
    },
    buffers = {
      theme = "ivy",
      prompt_title = false
    },
    spell_suggest = {
      theme = "cursor",
    },
    help_tags = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    tags = {
      theme = "dropdown",
    },
    grep_string = {
      theme = "ivy",
    },
    lsp_code_actions = {
      theme = "cursor",
    },
  },
  extensions = {
  },
}

-- To get https://github.com/nvim-telescope/telescope-fzf-native.nvim loaded and working
-- with Telescope, we need to call this AFTER the telescope setup function
require("telescope").load_extension("fzf")

-- Global mappings
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map('n', '<C-p>', '<Cmd>Telescope git_files<CR>', opts)
map('n', '<Leader>e', '<Cmd>Telescope find_files<CR>', opts)
map('n', '<Leader>b', '<Cmd>Telescope buffers<CR>', opts)
map('n', '<Leader><F1>', '<Cmd>Telescope help_tags<CR>', opts)
map('n', '<Leader>/', '<Cmd>Telescope live_grep<CR>', opts)
map('n', '<Leader><C-]>', '<Cmd>Telescope tags<CR>', opts)
map('n', '<Leader>?', '<Cmd>Telescope grep_string<CR>', opts)
map('n', 'z=', '<Cmd>Telescope spell_suggest<CR>', opts)
map('n', '<M-.>', '<Cmd>Telescope lsp_code_actions<CR>', opts)
map('n', '<Leader>o', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
map('n', '<Leader>O', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)

