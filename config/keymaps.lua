local opts = { noremap = true, silent = true }
local set = function(mode, key, vimcmd)
	vim.keymap.set(mode, key, vimcmd, opts)
end

if pcall(require, "neo-tree.command") then
	set("n", "<leader>t", function()
		require("neo-tree.command").execute({
			toggle = true,
			dir = vim.loop.cwd(),
		})
	end)
end

if pcall(require, "flash") then
	set({ "n", "o", "x" }, "s", function()
		require("flash").jump()
	end)
end

for i = 1, 9 do
	set("n", "<leader>" .. i, function()
		vim.cmd("BufferLineGoToBuffer " .. i)
	end)
end

set("n", "<leader>q", function()
	vim.cmd("BufferLinePickClose")
end)

local diagnostic = vim.diagnostic
set("n", "<leader>e", diagnostic.open_float)
set("n", "[d", diagnostic.goto_prev)
set("n", "]d", diagnostic.goto_next)
set("n", "<leader>u", diagnostic.setloclist)
set("n", "<leader>ca", vim.lsp.buf.code_action)

set("n", "<leader>f", function()
	vim.cmd("Telescope")
end)

set("n", "<leader>p", function()
	vim.cmd("TroubleToggle")
end)

set("n", "<leader>z", function()
	vim.cmd("FormatToggle")
end)
