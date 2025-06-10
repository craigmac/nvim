-- https://github.com/mfussenegger/nvim-dap
-- ~/.local/share/nvim/lazy/nvim-dap/
---@type LazyPluginSpec
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- better debug UI
    'nvim-neotest/nvim-nio', -- dependency for nvim-dap-ui
    'williamboman/mason.nvim', -- for installing debuggers
    'jay-babu/mason-nvim-dap.nvim', -- translation layer/helper like mason-lspconfig
  },
  enabled = false,
  keys = {
    { '<F5>', function() require('dap').continue() end },
    { '<F1>', function() require('dap').step_into() end },
    { '<F2>', function() require('dap').step_over() end },
    { '<F3>', function() require('dap').step_out() end },
  },
  config = function()
    require('mason-nvim-dap').setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    })

    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
