-- Git related plugins

return {
  -- Work with git inside nvim
  { 'tpope/vim-fugitive' },

  { 'tpope/vim-rhubarb' },

  -- Extend fugitive.vim to support Bitbucket URLs in :Gbrowse
  { 'tommcdo/vim-fubitive' },

  -- Mark changed lines(git) in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gs.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gs.nav_hunk('prev')
            end
          end)

          -- Actions
          map({ 'n' }, '<leader>hs', gs.stage_hunk)
          map('v', '<leader>hs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map({ 'n' }, '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)

          -- Text object
          map({ 'o', 'x' }, 'ih', gs.select_hunk)
        end
      }
    end
  },

  -- A git commit browser
  { 'junegunn/gv.vim' },
}
