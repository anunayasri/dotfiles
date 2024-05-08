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
    'pyright', 'gopls', 'jsonls', 'bashls', 'dockerls', 'vimls', 'mypy', -- 'ruff'
})

require('lspconfig').pyright.setup({
    on_attach = function(client, bufnr)
        print('hello pyright')
    end,
    filetypes = {"python"},
})

lsp.nvim_workspace()

lsp.setup()

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- make sure the source name is supported by null-ls
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.ruff,
  }
})

