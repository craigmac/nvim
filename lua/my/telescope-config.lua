local actions = require "telescope.actions"
local layouts = require "telescope.actions.layout"
-- local previewers = require "telescope.previewers"
-- local sorters = require "telescope.sorters"
-- local finders = require "telescope.finders"
-- local pickers = require "telescope.pickers"
-- local action_state = require "telescope.actions.state"
-- local conf = require("telescope.config").values
require("telescope").setup {
  defaults = {
    path_display = { "absolute" },
    mappings = {
      i = {
        ["<C-o>"] = layouts.toggle_preview,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    -- change configs for each builtin picker (each key is a picker name)
    git_files = {
      theme = "dropdown",
      previewer = false,
    },
    spell_suggest = {
      theme = "cursor",
    },
    grep_string = {
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
      previewer = false,
    },
    lsp_code_actions = {
      theme = "cursor",
    },
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

-- these need to come after main setup() call
require("telescope").load_extension "fzf"
-- sets vim.ui.select to use telescope so things like vim.lsp.buf.code_action()
-- will use telescope interface instead
require("telescope").load_extension "ui-select"
require("telescope").load_extension "gh"

vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader><Tab>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<Leader><F1>", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<Leader><C-]>", require("telescope.builtin").tags)
vim.keymap.set("n", "<Leader>:", require("telescope.builtin").commands)
vim.keymap.set("n", "z=", require("telescope.builtin").spell_suggest)
vim.keymap.set("n", '<Leader>"', require("telescope.builtin").registers)
