local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy
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

require("lazy").setup({
	--- general

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{ "j-hui/fidget.nvim", tag = "legacy" },
	{ "folke/flash.nvim", event = "VeryLazy" },

	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",

	{ "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	{ "echasnovski/mini.nvim", version = false, event = "VeryLazy" },

	--- completion

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"FelipeLema/cmp-async-path",
			"L3MON4D3/LuaSnip",
		},
	},

	--- ui

	{ "stevearc/dressing.nvim", lazy = true },
	{ "folke/noice.nvim", event = "VeryLazy" },
	{ "MunifTanjim/nui.nvim", lazy = true },
	"rcarriga/nvim-notify",

	--- lsp

	"neovim/nvim-lspconfig",

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
	},

	--- utils

	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "nvim-telescope/telescope.nvim", tag = "0.1.2" },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "folke/which-key.nvim", event = "VeryLazy" },
})
