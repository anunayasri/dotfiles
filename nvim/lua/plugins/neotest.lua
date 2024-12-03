return {

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python", -- python
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
          })
        },
      })

      -- neotest keymaps start with `t`
      set = vim.keymap.set
      set('n', '<leader>tn', function() neotest.run.run() end, { desc = "Run [n]earest test" })
      set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = "Run test [f]ile" })
      set('n', '<leader>tl', function() neotest.run.run_last() end, { desc = "Run [l]ast test" })
      set('n', '<leader>td', function() neotest.run.run({ strategy = "dap" }) end,
        { desc = "[D]ebug nearest test using Dap" })
      set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = "Toggle test [s]ummary" })
      set('n', '<leader>to', function() neotest.output_panel.toggle() end, { desc = "Toggle test [o]utput panel" })
      set('n', '<leader>tp', function() neotest.output.open({ enter = true, short = false }) end,
        { desc = "Show test output" })
      set('n', '<leader>tt', function() neotest.run.stop() end, { desc = "[T]erminate neotest " })
    end
  },

  -- {
  --   "nvim-neotest/neotest-python",
  --   dependencies = {
  --     "nvim-neotest/neotest"
  --   }
  -- },
  --
}
