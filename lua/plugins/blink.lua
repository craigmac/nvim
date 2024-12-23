require('blink.cmp').setup({

  keymap = {
    preset = 'default'
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  sources = {
    completion = {
      enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },

  -- experimental auto-brackets support
  -- completion = { accept = { auto_brackets = { enabled = true } } },

  -- experimental signature help support
  -- signature = { enabled = true }

  -- extend `completion.enabled_providers` without having to redefine it
  opts_extend = { "sources.completion.enabled_providers" }
})

