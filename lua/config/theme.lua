-- lua/config/theme.lua
local M = {}

-- Theme config - Tokyo Night colors (storm variant)
-- These are approximate colors from Tokyo Night Storm
M.colors = {
    bg = "#1a1b26",
    fg = "#c0caf5",
    blue = "#7aa2f7",
    teal = "#4fd6be",
    red = "#f7768e",
    green = "#9ece6a",
    yellow = "#e0af68",
    purple = "#bb9af7",
    orange = "#ff9e64",
    comment = "#565f89",
    surface = "#15161e",
}

-- Optional: Lualine theme compatible with Tokyo Night
M.tokyonight_theme = {
    normal = {
        a = { fg = M.colors.bg, bg = M.colors.purple },
        b = { fg = M.colors.fg, bg = M.colors.surface },
        c = { fg = M.colors.fg, bg = M.colors.bg },
    },
    insert = { a = { fg = M.colors.bg, bg = M.colors.blue } },
    visual = { a = { fg = M.colors.bg, bg = M.colors.teal } },
    replace = { a = { fg = M.colors.bg, bg = M.colors.red } },
    terminal = { a = { fg = M.colors.bg, bg = M.colors.orange } },
    command = { a = { fg = M.colors.bg, bg = M.colors.yellow } },
    inactive = {
        a = { fg = M.colors.fg, bg = M.colors.surface },
        b = { fg = M.colors.fg, bg = M.colors.surface },
        c = { fg = M.colors.fg, bg = M.colors.bg },
    },
}

-- Setup theme globals
function M.setup()
    vim.g.colors = M.colors
    vim.g.tokyonight_theme = M.tokyonight_theme
    -- Apply colorscheme
    -- vim.cmd.colorscheme("tokyonight")
end

return M
