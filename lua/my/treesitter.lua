
local status_ok, treesitter = pcall(require, "treesitter")
if not status_ok then
  return
end

-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.config").setup {
  highlight = {
    enable = true,
  },
  -- TODO: how does this work? grm relaced all selected with 'm's
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Auto jump forward like targets.vim plugin did
      keymaps = {
        -- You can use capture groups define in textobject.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = false, -- whether to add jump to jumplist (:jumps)
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },  -- move end
  }, -- textobjects end
} -- setup end



