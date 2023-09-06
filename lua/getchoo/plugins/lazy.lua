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
	{ "stevearc/dressing.nvim", lazy = true },
	{ "j-hui/fidget.nvim", tag = "legacy" },
	"lewis6991/gitsigns.nvim",
	{ "folke/flash.nvim", event = "VeryLazy" },
	"lukas-reineke/indent-blankline.nvim",
	{ "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "echasnovski/mini.nvim", version = false, event = "VeryLazy" },
	{ "folke/noice.nvim", event = "VeryLazy" },
	{ "MunifTanjim/nui.nvim", lazy = true },
	"neovim/nvim-lspconfig",
	"rcarriga/nvim-notify",
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	"nvim-lua/plenary.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.2" },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "folke/which-key.nvim", event = "VeryLazy" },
})
