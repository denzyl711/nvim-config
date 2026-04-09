return {
	{
		"folke/sidekick.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<Tab>",
				function()
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>"
					end
				end,
				expr = true,
				mode = { "n" },
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<F59>",
				function() require("sidekick.cli").focus() end,
				desc = "Hyper+G — focus sidekick terminal",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function() require("sidekick.cli").toggle() end,
				desc = "Sidekick toggle CLI",
			},
			{
				"<leader>as",
				function() require("sidekick.cli").select() end,
				desc = "Sidekick select CLI tool",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Sidekick send this",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Sidekick send selection",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Sidekick send file",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick select prompt",
			},
			{
				"<leader>ad",
				function() require("sidekick.cli").close() end,
				desc = "Sidekick close CLI session",
			},
		},
		opts = {
			cli = {
				mux = {
					enabled = true,
					backend = "tmux",
				},
				win = {
					split = {
						width = 55,
					},
				},
			},
		},
	},
}
