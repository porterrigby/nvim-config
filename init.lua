vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<CR>")

vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin List
require("lazy").setup({	
	"williamboman/mason.nvim",
	"nvim-tree/nvim-tree.lua",
	{"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" }},
	{"nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},


})

-- Plugin Setup
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    show_end_of_buffer = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
    },
})
vim.cmd.colorscheme "catppuccin"

local telescope = require("telescope.builtin")
vim.keymap.set('n', "<c-p>", telescope.find_files, {})
vim.keymap.set('n', "<leader>fg", telescope.live_grep, {})

require("nvim-treesitter.configs").setup({
    ensure_installed = {"java", "python", "c", "bash"},
    highlight = { enable = true },
    indent = { enable = true },
})

require("nvim-tree").setup()
require("lualine").setup()
require("mason").setup()

