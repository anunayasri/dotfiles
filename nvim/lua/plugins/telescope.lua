return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { "Myzel394/jsonfly.nvim" },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    }, -- end dependencies
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          prompt_prefix = "$ ",
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            },
          },
        }, -- end defaults
        pickers = {
          current_buffer_fuzzy_find = {
            previewer = false
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      } -- end telescope setup

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'jsonfly')
      pcall(require('telescope').load_extension, 'live_grep_args')

      -- Useful commands you can use
      --   :Telescope builtin - Finds Telescope's builtin commands
      --   :Telescope keymaps - Finds nvim keymaps

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find_files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live_grep: Grep in the workspace' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help_tags' })
      vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = 'Telescope treesitter: find symbols in the buffer' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope grep_string: find word under cursor' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope grep_string: find word under cursor' })
      vim.keymap.set('n', '<leader>fo', builtin.buffers, { desc = 'Telescope buffers: find open files' })

      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Telescope fuzzy find in current buffer [/]' })

      vim.keymap.set("n", "<leader>df", function()
        builtin.diagnostics({
          bufnr = 0, -- Show diagnostics only for the current buffer
        })
      end, { desc = "Show [d]iagnostics for current [f]ile" })
    end
  }, -- end telescope
}
