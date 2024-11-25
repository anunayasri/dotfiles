local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc='Telescope find_files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc='Telescope live_grep: Grep in the workspace'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc='Telescope buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc='Telescope help_tags'})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {desc='Telescope treesitter: find symbols in the buffer'})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc='Telescope grep_string: find word under cursor'})
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, {desc='Telescope fuzzy find the buffer'})

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

