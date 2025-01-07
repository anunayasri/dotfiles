-- Config related to code in a single file
-- Code Highlight: Treesitter and related plugins
-- Code Folding
-- Code Comments

local ufo_fold_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' ↙ %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      -- FIXME: a long list prints multiple text lines on vim enter.
      -- Probably check treesitter on opening a certain filetype
      ensure_installed = {
        'bash',
        'diff',
        'html',
        -- 'lua',
        -- 'luadoc',
        -- 'vim',
        -- 'vimdoc',
        'markdown',
        -- 'markdown_inline',
        -- 'query',
        'json',
        'yaml',

        -- docker stuff
        -- 'dockerfile',

        -- python stuff
        'python',

        -- go stuff
        -- 'go',
        -- 'gomod'
      },
      -- Autoinstall tries to check for parsers on nvim startup. This breaks occasionally. Disable it.
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    }, -- end opts
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  }, -- end treesitter

  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    config = function()
      -- fold config for ufo
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
        -- global handler
        -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
        -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
        fold_virt_text_handler = ufo_fold_handler,
      }) -- end setup
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    -- opts = {
    --   mutliline_threshold = 1
    -- },
    config = function()
      vim.cmd('hi TreesitterContext gui=underline guisp=Grey')
      require 'treesitter-context'.setup {
        multiline_threshold = 1,
      }
    end
  },

  -- Better code comments
  { 'numToStr/Comment.nvim' },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          python = {
            -- To fix auto-fixable lint errors.
            "ruff_fix",
            -- To run the Ruff formatter.
            "ruff_format",
            -- To organize the imports.
            "ruff_organize_imports",
          },
          json = { "jq" }
        }, -- end formatters_by_ft
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }) -- end setup

      vim.keymap.set('n', '<leader>cf', function()
        conform.format({
          bufnr = vim.api.nvim_get_current_buf(),
          timeout_ms = 500,
          lsp_format = "fallback",
        })
      end, { desc = '' })
    end -- end config
  },

  {
    "phelipetls/jsonpath.nvim",
    ft = "json",
    config = function()
      -- show json path in the winbar
      if vim.fn.exists("+winbar") == 1 then
        vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
      end

      -- send json path to clipboard
      vim.keymap.set("n", "y<C-p>", function()
        vim.fn.setreg("+", require("jsonpath").get())
      end, { desc = "copy json path", buffer = true })
    end
  },

}
