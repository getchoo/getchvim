local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.vim"

-- bootstrap lazy
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazy_path,
	})
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"saadparwaiz1/cmp_luasnip",
	"FelipeLema/cmp-async-path",
	{ "j-hui/fidget.nvim", tag = "legacy" },
	"lewis6991/gitsigns.nvim",
	{ "folke/flash.nvim", event = "VeryLazy" },
	{ "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	"L3MON4D3/LuaSnip",
	{ "echasnovski/mini.pairs", event = "VeryLazy" },
	"neovim/nvim-lspconfig",
	{ "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons" },
	"nvim-treesitter/nvim-treesitter",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", tag = "0.1.2" },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
})
