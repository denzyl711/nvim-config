return {
	"relf108/nvim-unstack",
	event = "VeryLazy",
	version = "*",
	opts = {
		debug = false,
		showsigns = true,
		layout = "quickfix_list",
		mapkey = false, -- We'll define our own mapping below
	},
	config = function(_, opts)
		require("nvim-unstack").setup(opts)

		-- Wrapper: run unstack, then open quickfix in fzf-lua
		local function unstack_to_fzf()
			-- Yank the visual selection to system clipboard
			vim.cmd('normal! "+y')
			-- Hide floaterm if any is open
			pcall(function() vim.cmd("FloatermHide") end)
			-- Run unstack from clipboard
			vim.cmd("UnstackFromClipboard")
			-- Close the quickfix window if it opened, then show fzf picker
			vim.defer_fn(function()
				vim.cmd("cclose")
				if #vim.fn.getqflist() > 0 then
					require("fzf-lua").quickfix()
				end
			end, 10)
		end

		vim.keymap.set("v", "<leader>s", unstack_to_fzf, { desc = "Unstack to fzf" })
	end,
}
