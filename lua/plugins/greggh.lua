return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- Keymaps (lazy-loaded)
    keys = {
      {
        "<leader>cc",
        "<cmd>ClaudeCode<CR>",
        desc = "Toggle Claude Code",
      },
      {
        "<leader>cC",
        "<cmd>ClaudeCodeContinue<CR>",
        desc = "Claude Continue",
      },
      {
        "<leader>cr",
        "<cmd>ClaudeCodeResume<CR>",
        desc = "Claude Resume",
      },
    },

    config = function()
      -- When re-entering the claude-code terminal buffer (e.g. after switching
      -- away and back), scroll to the bottom and resume terminal mode so the
      -- cursor lands in the right place
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "term://*claude*",
        callback = function()
          vim.cmd("normal! G")
          vim.cmd("startinsert")
        end,
      })

      require("claude-code").setup({
        window = {
          position = "float",
          float = {
            width = "85%",
            height = "85%",
            row = "center",
            col = "center",
            relative = "editor",
            border = "rounded",
          },
        },
      })
    end,
  },
}
