-- Global mappnigs for debugger across languages

local dap = require('dap')
-- vim.keymap.set('n', '<F1>', function() require('dap').continue() end, {desc='dap: Start debugger'})
-- vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, {desc='dap: Step over'})
-- vim.keymap.set('n', '<F3>', function() require('dap').step_into() end, {desc='dap: Step into'})
-- vim.keymap.set('n', '<F4>', function() require('dap').step_out() end, {desc='dap: Step out'})
vim.keymap.set('n', '<Leader>dc', function() dap.continue() end, {desc='dap: [C]ontinue'})
vim.keymap.set('n', '<Leader>dj', function() dap.step_over() end, {desc='dap: Step Over [j]'})
vim.keymap.set('n', '<Leader>dk', function() dap.step_back() end, {desc='dap: Step Back [k]'})
vim.keymap.set('n', '<Leader>dl', function() dap.step_into() end, {desc='dap: Step Into [l]'})
vim.keymap.set('n', '<Leader>dh', function() dap.step_out() end, {desc='dap: Step Out [h]'})
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, {desc='dap: Toggle [b]reakpoint'})
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, {desc='dap: Set [B]reakpoint'})
vim.keymap.set('n', '<Leader>dbc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {desc='dap: Set breakpoint condition'})
vim.keymap.set('n', '<Leader>dbl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc='dap: Set breakpoint with [l]og'})
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.toggle() end, {desc='dap: Open [r]epl'})
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, {desc='dap: Run [l]ast'})
vim.keymap.set('n', '<Leader>ddc', function() dap.run_to_cursor() end, {desc='dap: Run to [c]ursor'})
vim.keymap.set('n', '<Leader>dq', function() dap.terminate() end, {desc='dap: Terminate [q]'})

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

require("dapui").setup()

-- Automatically open dapui on starting debugging
local dap, dapui = require("dap"), require("dapui")
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
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🟠', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='❗', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='📍', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='debugPC', numhl=''})


require("nvim-dap-virtual-text").setup()

-- Go debugger config

require("dap-go").setup()
vim.keymap.set('n', '<Leader>dt', function() require('dap-go').debug_test() end)

-- Python debugger config 

require('dap-python').setup('~/.myvenv/debugpy/bin/python')
require("dap-python").test_runner = "pytest"

-- neotest & neotest-python

local neotest = require('neotest')

neotest.setup({
  adapters = {
    require("neotest-python")({
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
    })
  }
})

-- neotest keymaps start with `t`
vim.keymap.set('n', '<leader>tn', function() neotest.run.run() end, { desc = "Run [n]earest test" })
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = "Run test [f]ile" })
vim.keymap.set('n', '<leader>tl', function() neotest.run.run_last() end, { desc = "Run [l]ast test" })
vim.keymap.set('n', '<leader>td', function() neotest.run.run({strategy = "dap"}) end, { desc = "[D]ebug nearest test using Dap" })
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = "Toggle test [s]ummary" })
vim.keymap.set('n', '<leader>to', function() neotest.output_panel.toggle() end, { desc = "Toggle test [o]utput panel" })
vim.keymap.set('n', '<leader>tp', function() neotest.output.open({ enter = true, short = false }) end, { desc = "Show test output" })
vim.keymap.set('n', '<leader>tt', function() neotest.run.stop() end, { desc = "[T]erminate neotest " })

