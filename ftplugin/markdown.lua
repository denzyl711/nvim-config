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

-- Define a highlight group for completed todos: grey + strikethrough
vim.api.nvim_set_hl(0, "TodoDone", { strikethrough = true, fg = "#6c7086" })

-- Apply that highlight to any line matching `- [x] ...` (works on top of treesitter)
vim.fn.matchadd("TodoDone", [[^\s*- \[x\].*]])

-- <leader>x: toggle [ ] <-> [x] on the current line
vim.keymap.set("n", "<leader>x", function()
	local line = vim.api.nvim_get_current_line()
	local new_line
	if line:match("%- %[ %]") then
		-- unchecked -> checked
		new_line = line:gsub("%- %[ %]", "- [x]", 1)
	elseif line:match("%- %[x%]") then
		-- checked -> unchecked
		new_line = line:gsub("%- %[x%]", "- [ ]", 1)
	else
		return -- not a todo line, do nothing
	end
	vim.api.nvim_set_current_line(new_line)
end, { buffer = 0, desc = "Toggle todo done" })
