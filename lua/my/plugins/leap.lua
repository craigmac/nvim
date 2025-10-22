return {
  'ggandor/leap.nvim',
  enabled = false,
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
    vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

    -- rebind f/F and t/T to use leap (copied from README file):
    local function as_ft (key_specific_args)
      local common_args = {
        inputlen = 1,
        inclusive = true,
        -- limits search scope to the current line
        pattern = function (pat) return '\\%.l'..pat end,
        opts = {
          labels = '',
          safe_labels = vim.fn.mode(1):match'[no]' and '' or nil,
          case_sensitive = true,
        },
      }
      return vim.tbl_deep_extend('keep', common_args, key_specific_args)
    end

    local clever = require('leap.user').with_traversal_keys
    local clever_f = clever('f', 'F')
    local clever_t = clever('t', 'T')

    for key, key_specific_args in pairs {
      f = { opts = clever_f, },
      F = { backward = true, opts = clever_f },
      t = { offset = -1, opts = clever_t },
      T = { backward = true, offset = 1, opts = clever_t },
    } do
    vim.keymap.set({'n', 'x', 'o'}, key, function ()
      require('leap').leap(as_ft(key_specific_args))
    end)
      end
  end,
}
