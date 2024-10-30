local M = {}

M.set_keymap = function(mode, key, vimcmd)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, key, vimcmd, opts)
end

M.lazy_file = { "BufReadPost", "BufNewFile", "BufWritePre" }

return M
