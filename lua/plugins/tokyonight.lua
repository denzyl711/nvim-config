return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local c = require("tokyonight.colors").setup({ style = "night" })

    require("tokyonight").setup({
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
      },
      sidebars = { "qf", "help", "NvimTree", "vista_kind", "terminal", "packer" },
      lualine_bold = true,

      on_highlights = function(hl, colors)
        -- Function calls distinct from definitions
        hl["@function.call"] = { fg = colors.blue }
        hl["@method.call"] = { fg = colors.blue }

        -- Parameters (VSCode colours these distinctly)
        hl["@variable.parameter"] = { fg = colors.orange }
        hl["@lsp.type.parameter"] = { fg = colors.orange }

        -- Member variables / properties
        hl["@variable.member"] = { fg = colors.fg }
        hl["@lsp.type.property"] = { fg = colors.fg }

        -- Types, classes, interfaces
        hl["@type"] = { fg = colors.teal }
        hl["@type.builtin"] = { fg = colors.teal, italic = true }
        hl["@lsp.type.class"] = { fg = colors.teal }
        hl["@lsp.type.interface"] = { fg = colors.teal, italic = true }
        hl["@lsp.type.struct"] = { fg = colors.teal }
        hl["@lsp.type.enum"] = { fg = colors.teal }
        hl["@lsp.type.typeParameter"] = { fg = colors.teal }

        -- Namespaces / modules
        hl["@module"] = { fg = colors.blue1 }
        hl["@lsp.type.namespace"] = { fg = colors.blue1 }

        -- Constants (ALL_CAPS style)
        hl["@constant"] = { fg = colors.orange }
        hl["@constant.builtin"] = { fg = colors.orange, bold = true }
        hl["@lsp.type.enumMember"] = { fg = colors.orange }

        -- self / this
        hl["@variable.builtin"] = { fg = colors.red, italic = true }
        hl["@lsp.type.selfKeyword"] = { fg = colors.red, italic = true }

        -- String escapes and special chars in strings
        hl["@string.escape"] = { fg = colors.yellow }
        hl["@string.special"] = { fg = colors.yellow }

        -- Decorators / annotations
        hl["@attribute"] = { fg = colors.yellow }
        hl["@lsp.type.decorator"] = { fg = colors.yellow }

        -- Punctuation delimiters (brackets, parens, commas)
        hl["@punctuation.bracket"] = { fg = colors.fg_dark }
        hl["@punctuation.delimiter"] = { fg = colors.fg_dark }

        -- Operators
        hl["@operator"] = { fg = colors.blue5 }
      end,
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
