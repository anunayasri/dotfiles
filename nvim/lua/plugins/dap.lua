-- Auto format only python and lua files
-- Auto format command / shortcut for all file types.
-- Neotest integration
-- Dap integration == Done
-- surround.mini integration
-- cmp: First choice should be auto selected
-- buffer, emoji cmp for all file types

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope-dap.nvim",
      "williamboman/mason.nvim",
      'mfussenegger/nvim-dap-python' -- needs debugpy python debugger
    },
    config = function()
      -- Global mappnigs for debugger across languages
      local dap = require("dap")

      local set = vim.keymap.set

      set('n', '<Leader>dc', function() dap.continue() end, { desc = 'dap: [C]ontinue' })
      set('n', '<Leader>dj', function() dap.step_over() end, { desc = 'dap: Step Over [j]' })
      set('n', '<Leader>dk', function() dap.step_back() end, { desc = 'dap: Step Back [k]' })
      set('n', '<Leader>dl', function() dap.step_into() end, { desc = 'dap: Step Into [l]' })
      set('n', '<Leader>dh', function() dap.step_out() end, { desc = 'dap: Step Out [h]' })
      set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'dap: Toggle [b]reakpoint' })
      set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, { desc = 'dap: Set [B]reakpoint' })
      set('n', '<Leader>dbc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        { desc = 'dap: Set breakpoint condition' })
      set('n', '<Leader>dbl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = 'dap: Set breakpoint with [l]og' })
      set('n', '<Leader>dr', function() require('dap').repl.toggle() end, { desc = 'dap: Open [r]epl' })
      set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 'dap: Run [l]ast' })
      set('n', '<Leader>ddc', function() dap.run_to_cursor() end, { desc = 'dap: Run to [c]ursor' })
      set('n', '<Leader>dq', function() dap.terminate() end, { desc = 'dap: Terminate [q]' })

      local dapui_widgets = require("dap.ui.widgets")

      set({ 'n', 'v' }, '<Leader>dh', function()
        dapui_widgets.hover()
      end)
      set({ 'n', 'v' }, '<Leader>dp', function()
        dapui_widgets.preview()
      end)
      set('n', '<Leader>df', function()
        dapui_widgets.centered_float(widgets.frames)
      end)
      set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        dapui_widgets.centered_float(widgets.scopes)
      end)

      local dapui = require("dapui")
      dapui.setup()

      -- Automatically open dapui on starting debugging
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Customize DAP icons
      local sign_define = vim.fn.sign_define

      sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      sign_define('DapBreakpointCondition', { text = '🟠', texthl = '', linehl = '', numhl = '' })
      sign_define('DapBreakpointRejected', { text = '❗', texthl = '', linehl = '', numhl = '' })
      sign_define('DapLogPoint', { text = '📍', texthl = '', linehl = '', numhl = '' })
      sign_define('DapStopped', { text = '➡️', texthl = '', linehl = 'debugPC', numhl = '' })


      require("nvim-dap-virtual-text").setup()

      -- Go debugger config

      -- require("dap-go").setup()
      -- vim.keymap.set('n', '<Leader>dt', function() require('dap-go').debug_test() end)

      -- Python debugger config

      require('dap-python').setup('$HOME/.myvenv/debugpy/bin/python')
      require("dap-python").test_runner = "pytest"
    end
  },
}
