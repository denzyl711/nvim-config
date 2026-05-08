return {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
        { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find TODOs" },
    },
    opts = {},
}
