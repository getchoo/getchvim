local opts = { noremap = true, silent = true }
local set = function(mode, key, vimcmd)
	vim.keymap.set(mode, key, vimcmd, opts)
end

set("n", "<leader>t", function()
	local files = require("mini.files")
	if not files.close() then
		files.open()
	end
end)

set({ "n", "o", "x" }, "s", function()
	require("flash").jump()
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
	vim.cmd("Trouble diagnostics toggle")
end)

set("n", "<leader>z", function()
	vim.cmd("FormatToggle")
end)
