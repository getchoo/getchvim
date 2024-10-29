return {
	{
		"fidget.nvim",
		-- https://github.com/LazyVim/LazyVim/blob/cb40a09538dc0c417a7ffbbacdbdec90be4a792c/lua/lazyvim/util/plugin.lua#L9
		event = require("getchoo.utils").lazy_file,
		after = function()
			require("fidget").setup()
		end
	}
}
