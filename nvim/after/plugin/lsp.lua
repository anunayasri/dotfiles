require("fidget").setup{}

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr})
--
--   vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
--   vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = true})
-- end)

lsp.ensure_installed({
    'pyright', 'gopls', 'jsonls', 'bashls', 'dockerls', 'vimls', 'ruff'
})

local lspconf = require('lspconfig')

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

lspconf.pyright.setup({
    on_attach = function(client, bufnr)
        print('hello pyright. python exec: ', settings.python.pythonPath)
    end,
    filetypes = {"python"},
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
        disableTaggedHints = true,
      },
      python = {
        pythonPath = vim.fn.exepath("python3"),
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
          diagnosticSeverityOverrides = {
            -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
            reportUndefinedVariable = "none",
          },
        },
      },
    },
})

-- lspconf.ruff.setup({
--     init_options = {
--       settings = {
--
--       }
--     }
-- })

lspconf.ruff.setup{}

lsp.nvim_workspace()

lsp.setup()

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- make sure the source name is supported by null-ls
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.ruff,
  }
})

-- https://lsp-zero.netlify.app/v3.x/autocomplete.html
local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format({details = true})

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'emoji'},
  },
  -- to limit the width of pop window
  formatting = {
    format = function(entry, vim_item) 
      vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      return vim_item
    end
  },
})

require('todo-comments').setup{}
