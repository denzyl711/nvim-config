local M = {}

function M.pick()
	local fzf = require("fzf-lua")
	local lazy = require("lazy")
	local theme_map = require("config.themes")

	local function apply(plugin, colorscheme)
		pcall(function() lazy.load({ plugins = { plugin } }) end)
		pcall(vim.cmd.colorscheme, colorscheme)
	end

	local families = vim.tbl_keys(theme_map)
	table.sort(families)

	fzf.fzf_exec(families, {
		prompt = "Theme> ",
		previewer = false,
		winopts = { height = 0.4, width = 0.3 },
		actions = {
			["default"] = function(selected)
				local entry = theme_map[selected[1]]
				if #entry.variants == 1 then
					apply(entry.plugin, entry.variants[1])
				else
					fzf.fzf_exec(entry.variants, {
						prompt = selected[1] .. " variant> ",
						previewer = false,
						winopts = { height = 0.4, width = 0.35 },
						actions = {
							["default"] = function(v)
								apply(entry.plugin, v[1])
							end,
						},
					})
				end
			end,
		},
	})
end

return M
