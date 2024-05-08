-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-telescope/telescope-fzf-native.nvim',
	  run = 'make',
  }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
  })

  use({
	  'joshdick/onedark.vim',
	  as = 'onedark',
  })

  use {
	  'nvim-treesitter/nvim-treesitter',
	  -- run = ':TSUpdate',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }

  -- For beautiful folds
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  use('tpope/vim-fugitive')

  -- Extend fugitive.vim to support Bitbucket URLs in :Gbrowse
  use('tommcdo/vim-fubitive')

  use('junegunn/gv.vim')

  -- Mark changed lines(git) in the gutter
  use('lewis6991/gitsigns.nvim')

  -- Vifm file browser for vim
  use('vifm/vifm.vim')

  use('sheerun/vim-polyglot')

  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'numToStr/Comment.nvim'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {
        'j-hui/fidget.nvim',
        tag='legacy',
        config = function()
          require("fidget").setup {
            -- options
          }
        end,
      },

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      -- Validate popular json files like package.json
      {"b0o/schemastore.nvim"},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},

      -- null-ls
      {'jose-elias-alvarez/null-ls.nvim'},
    }
  }

  -- Debugger
  use {
    'mfussenegger/nvim-dap', -- needs go delve
    requires = {
      {"rcarriga/nvim-dap-ui"},
      {"theHamsta/nvim-dap-virtual-text"},
      {"nvim-telescope/telescope-dap.nvim"},
    }
  }

  -- Golang
  use {
	  'fatih/vim-go',
	  run = ':GoUpdateBinaries',
  }

  use { 'leoluz/nvim-dap-go' }

  -- python
  use {
    'mfussenegger/nvim-dap-python' -- needs debugpy python debugger
  }

  -- File structure in sidebar
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }

  use 'nvim-treesitter/nvim-treesitter-context'

  use 'mortepau/codicons.nvim'

  -- tmux related plugins
  use {'christoomey/vim-tmux-navigator'}

end)
