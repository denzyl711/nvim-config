-- Auto-show tag completion when cursor is right after `- [ ] [`
vim.api.nvim_create_autocmd("TextChangedI", {
	buffer = 0,
	callback = function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local before = vim.api.nvim_get_current_line():sub(1, col)
		if before:match("^%s*%- %[ %] %[$") then
			require("blink.cmp").show()
		end
	end,
})
