return {
  "folke/tokyonight.nvim",
  lazy = false,       -- load immediately
  priority = 1000,    -- make sure it loads before other plugins
  config = function()
    -- Setup options
    require("tokyonight").setup({
      style = "night",       -- options: "storm", "night", "day"
      transparent = false,   -- true for transparent background
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
      },
      sidebars = { "qf", "help", "NvimTree", "vista_kind", "terminal", "packer" },
      lualine_bold = true,
    })

    -- Apply colorscheme
    vim.cmd.colorscheme("tokyonight")
  end,
}
