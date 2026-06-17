local opts = { noremap = true, silent = true }

-- Clear <C-t> tag-stack default (used as floaterm prefix instead)
vim.keymap.set("n", "<C-t>", "<Nop>", opts)

-- Clear search highlight
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlight" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])

-- Window navigation: move between splits using Ctrl + h/j/k/l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
-- Terminal mode: allow same keys to move out of terminal splits
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Remap macro record to <leader>q (q is used by plugins)
vim.keymap.set("n", "<leader>q", "q", { noremap = true, desc = "Record macro" })
vim.keymap.set("n", "q", "<Nop>", { noremap = true })

-- Center screen after motions.
-- feedkeys with "m" flag so the motion resolves through any plugin remaps
-- (e.g. treesitter remaps [[ and ]]) before appending zz.
local function motion_center(motion)
  return function()
    local keys = vim.api.nvim_replace_termcodes(motion .. "zz", true, false, true)
    vim.api.nvim_feedkeys(keys, "m", false)
  end
end

-- vim.keymap.set("n", "{",  motion_center("{"),  { silent = true })
-- vim.keymap.set("n", "}",  motion_center("}"),  { silent = true })
vim.keymap.set("n", "[[", motion_center("[["), { silent = true })
vim.keymap.set("n", "]]", motion_center("]]"), { silent = true })
