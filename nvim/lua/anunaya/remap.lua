vim.g.mapleader = " "

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

-- Set cursor as vertical line in insert mode
vim.opt.guicursor = "i:ver25-iCursor"
vim.opt.termguicolors = true

vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.colorcolumn = "81"

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

-- Work with neovim config files
vim.keymap.set("n", "<leader>ev", function() vim.cmd(":tabnew ~/.config/nvim/lua/anunaya") end)
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

