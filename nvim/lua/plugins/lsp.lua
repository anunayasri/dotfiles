-- return {
--   {
--     'VonHeikemen/lsp-zero.nvim',
--     branch = 'v2.x',
--     dependencies = {
--       -- LSP Support
--       {'neovim/nvim-lspconfig'},
--       {'williamboman/mason.nvim'},
--       {'williamboman/mason-lspconfig.nvim'},
--       -- `opts = {}` is the same as calling `require('fidget').setup({})`
--       { 'j-hui/fidget.nvim', opts = {} },
--
--       -- Autocompletion
--       {'hrsh7th/nvim-cmp'},
--       {'hrsh7th/cmp-buffer'},
--       {'hrsh7th/cmp-path'},
--       {'saadparwaiz1/cmp_luasnip'},
--       {'hrsh7th/cmp-nvim-lsp'},
--       {'hrsh7th/cmp-nvim-lua'},
--       -- Validate popular json files like package.json
--       {"b0o/schemastore.nvim"},
--
--       -- Snippets
--       {'L3MON4D3/LuaSnip'},
--       {'rafamadriz/friendly-snippets'},
--
--       -- null-ls
--       {'jose-elias-alvarez/null-ls.nvim'},
--     },
--   }
-- }

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

  -- Autocompletion
  -- This can work without lsp. Probably move it to code-file.lua
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Validate popular json files like package.json
      { "b0o/schemastore.nvim" },
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      -- Set the pop window height
      -- We don't want a long pop window!
      vim.o.pumheight = math.floor(vim.o.lines * 0.3)

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' }, -- lsp dependent. others are lsp independent
          { name = 'buffer' },
          { name = 'path' },
          { name = 'emoji' },
        },

        completion = {
          completeopt = 'menu,menuone,noinsert'
        },

        window = {
          documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
            max_width = 50,
            min_width = 50,
            max_height = math.floor(vim.o.lines * 0.4),
            min_height = 3,
          },
          max_item = 10,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),

        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        -- to limit the width of pop window
        formatting = {
          format = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
            return vim_item
          end
        },

      }) -- end cmp.setup()
    end
  },

  -- LSP

  -- lazydev.nvim is a plugin that properly configures LuaLS for editing your
  -- Neovim config by lazily updating your workspace libraries.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client == nil then
            return
          end

          if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end

          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', function()
            require('telescope.builtin').lsp_references()
          end, opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          -- Use conform for formatting
          -- vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set("n", "gl", function()
            vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
          end, { desc = "[G]o to [l]ine diagnostics" })
        end,
      }) -- end LspAttach

      lspconfig.pyright.setup({
        filetypes = { "python" },
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
          }, -- end python
        },   -- end settings
      })     -- end pyright setup


      lspconfig.ruff.setup {}

      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',   -- for bash scripts
          'lua_ls',   -- for nvim configs
          'jsonls',   -- for json files
          'dockerls', -- docker is everywhere
          -- python project
          'ruff',     -- python formatter & linter
          'pyright',  -- python intellisense
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  }, -- end neovim/nvim-lspconfig

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          -- make sure the source name is supported by null-ls
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          -- null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff, -- python linter
          null_ls.builtins.formatting.ruff,  -- python formatter
        },
        on_attach = function(client, bufnr)
          -- Autoformat on file write
          -- if client.supports_method("textDocument/formatting") then
          --   vim.api.nvim_create_autocmd("BufWritePre", {
          --     buffer = bufnr,
          --     callback = function()
          --         vim.lsp.buf.format({ async = false })
          --     end,
          --   })
          -- end

          -- Code Action
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      }) -- end null_ls.setup()
    end
  },     -- end null-ls.nvim
}
