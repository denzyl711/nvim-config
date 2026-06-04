-- Custom blink.cmp source that reads tags from tasks/active.md in your notes dir.
-- Triggers on `[` after a todo marker `- [ ] [` in markdown files.
-- Configure NOTES_DIR in ~/.config/nvim/.env

local source = {}

local function load_dotenv()
	local env = {}
	local file = io.open(vim.fn.stdpath("config") .. "/.env", "r")
	if not file then return env end
	for line in file:lines() do
		local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
		if key and value then env[key] = value end
	end
	file:close()
	return env
end

local dotenv = load_dotenv()
local NOTES_DIR = dotenv.NOTES_DIR or (vim.fn.expand("~") .. "/Desktop/notes")

source.new = function()
	return setmetatable({}, { __index = source })
end

--- Read and parse tags from active.md
local function get_tags()
	local path = NOTES_DIR .. "/tasks/active.md"
	local file = io.open(path, "r")
	if not file then
		return {}
	end

	local tags = {}
	local in_table = false
	for line in file:lines() do
		-- Detect the table header row
		if line:match("^%s*|%s*Tag%s*|") then
			in_table = true
		elseif in_table then
			-- Stop at blank line or non-table line
			if not line:match("^%s*|") then
				break
			end
			-- Skip separator row (|---|---|)
			if not line:match("^%s*|%-") then
				local tag = line:match("`(%[.-%])`")
				local workstream = line:match("`%[.-%]`%s*|%s*(.-)%s*|")
				if tag then
					table.insert(tags, { tag = tag, workstream = workstream or "" })
				end
			end
		end
	end
	file:close()
	return tags
end

source.get_trigger_characters = function()
	return { "[" }
end

source.get_completions = function(self, context, callback)
	local empty = { items = {}, is_incomplete_forward = false, is_incomplete_backward = false }

	if vim.bo.filetype ~= "markdown" then
		callback(empty)
		return
	end

	local tags = get_tags()
	local items = {}
	for _, t in ipairs(tags) do
		table.insert(items, {
			label = t.tag,
			kind = vim.lsp.protocol.CompletionItemKind.EnumMember,
			detail = t.workstream,
			insertText = t.tag:match("%[(.-)%]") or t.tag,
			documentation = t.workstream,
		})
	end

	callback({
		items = items,
		is_incomplete_forward = false,
		is_incomplete_backward = false,
	})
end

return source
