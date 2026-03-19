return {
  "famiu/bufdelete.nvim",
  config = function()
    vim.keymap.set("n", "<leader>bd", function()
      require("bufdelete").bufdelete(0)
    end, { desc = "Delete buffer" })
  end,
}
