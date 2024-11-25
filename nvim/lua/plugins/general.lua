return {
  -- the colorscheme should be available when starting Neovim
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- must load the colorscheme during startup
    priority = 1000, -- must load this before all the other start plugins
    opts = {
      -- FIXME: This is not working. Why? `opts` should have worked.
      -- styles = {
      --   italic = false,
      -- }
    },
    config = function()
      require("rose-pine").setup({
        styles = {italic=false}
      })
      -- load the colorscheme here
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- :StartupTime to view startup event timing
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Better vim.input and vim.select UI elements
  { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- TODO: Explore this more
  {
    "monaqa/dial.nvim",
    -- lazy-load on keys
    -- mode is `n` by default. For more advanced options, check the section on key mappings
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  -- TODO: See if this is helpful
  { 
    "folke/noice.nvim",
    event = "VeryLazy",
  },

  -- Pretty icons, but requires a Nerd Font.
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup {
            options = {
                theme = "auto", -- Or choose a theme like 'gruvbox', 'onedark', etc.
            },
            sections = {
                lualine_a = {},
                lualine_b = {
                    { 'filename', color = { fg = "#ff5f87", bg = "#1e1e2e", gui = "bold" } },
                },
                lualine_c = {'diagnostics'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
        }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require("ibl").setup()
    end
  },

  -- File browsewr
  { "vifm/vifm.vim" },

  -- Make nvim and tmux work seamlessly with each other
  { "christoomey/vim-tmux-navigator" },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },

}
