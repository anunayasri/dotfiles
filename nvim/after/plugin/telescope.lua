local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, {})

local actions = require "telescope.actions"
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
  },
  pickers = {
    current_buffer_fuzzy_find = {
      previewer = false
    },
  }
}

require('telescope').load_extension('fzf')

