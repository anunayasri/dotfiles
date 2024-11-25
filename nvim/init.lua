-- Config that is native to neovim & doesn't require any external dependency

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.g.have_nerd_font = true

-- Set cursor as vertical line in insert mode
vim.opt.guicursor = "i:ver25-iCursor"
vim.opt.termguicolors = true

vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.colorcolumn = "121"

vim.opt.list = true
vim.opt.listchars = {trail='.', tab='  '}

-- Open the buffer is a new tab
vim.opt.switchbuf = "usetab,newtab"

-- Give more space for displaying messages.
vim.opt.cmdheight=2
-- change history to 1000
vim.opt.history=1000

-- Where should the new splits appear
vim.opt.splitbelow = true
vim.opt.splitright = true

-- stop yanking text on pasting over selection
vim.keymap.set('v', 'p', 'P')

-- Work with neovim config files
-- TODO: File location is hardcoded.
vim.keymap.set("n", "<leader>ev", function() vim.cmd(":tabnew ~/.config/nvim/lua/anunaya") end)
-- TODO: Use stdpath('config')
vim.keymap.set("n", "<leader><CR>", function() vim.cmd(":so ~/.config/nvim/init.lua") end)

-- Easy tab navigation
vim.keymap.set("n", "tl", vim.cmd.tabnext)
vim.keymap.set("n", "th", vim.cmd.tabprevious)
vim.keymap.set("n", "tn", vim.cmd.tabnew)

-- Align blocks of text and keep them selected
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Easy movement in the page
-- vim.keymap.set("n", "H", "^")
-- vim.keymap.set("n", "L", "g_")
vim.keymap.set({"n", "v"}, "<C-j>", "5j")
vim.keymap.set({"n", "v"}, "<C-k>", "5k")

-- Save the file
vim.keymap.set("n", "<Leader><Leader>", ":w<CR>")

-- Substitue the word under cursor
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Useful substitutions
-- Probably use snippets for this!

vim.cmd("iabbrev <expr> ,d strftime('%Y-%m-%d')")
vim.cmd("iabbrev <expr> ,t strftime('%Y-%m-%dT%TZ')")
vim.cmd("inoreabbrev <expr> ,u system('uuidgen')->trim()->tolower()")

-- Command to copy the current file's relative path to clipboard
vim.api.nvim_create_user_command("CopyRelPath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Command to copy the current file's absolute path to clipboard
vim.api.nvim_create_user_command("CopyAbsPath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Restart neovim with the same session
vim.api.nvim_create_user_command("Restart", function()
    vim.cmd("mksession! ~/.tmp-nvim-session.vim")
    vim.cmd("qa!") -- Quit Neovim
    os.execute("nvim -S ~/.tmp-nvim-session.vim") -- Restart Neovim
end, { desc = "Save session and restart Neovim" })


-- Plugins
--
-- Install Lazy
--
-- lazy.nvim setup config is in `~/.config/nvim/config/lazy.lua`
-- These commands download lazy.vim if not already present.
--
-- Uninstall Lazy
--
-- Source: https://lazy.folke.io/usage#-uninstalling
-- rm ~/.local/share/nvim/lazy
-- rm ~/.local/state/nvim/lazy
-- rm ~/.config/nvim/lazy-lock.json
--
-- Folder Structure
-- ~/.config/nvim
-- ├── lua
-- │   ├── config
-- │   │   └── lazy.lua
-- │   └── plugins
-- │       ├── spec1.lua
-- │       ├── **
-- │       └── spec2.lua
-- └── init.lua
--
-- Each file in `plugins/` folder should return a table with the plugins you
-- want to install.

--  To check the current status of your plugins, run
--    :Lazy
--
--  To update plugins run
--    :Lazy update
--
--  Debugging and Profiling
--  https://lazy.folke.io/usage/profiling
--
--  To check the health status
--    :checkhealth lazy

require("config.lazy")
