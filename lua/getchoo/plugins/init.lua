if vim.g.use_lazy then
	require("getchoo.plugins.lazy")
end

require("getchoo.plugins.general")
require("getchoo.plugins.lsp")
require("getchoo.plugins.ui")

if vim.g.auto_install then
	require("getchoo.plugins.mason")
end
