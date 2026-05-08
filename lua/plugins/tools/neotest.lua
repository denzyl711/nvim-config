return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    keys = {
        { "<leader>nn", function() require("neotest").run.run() end, desc = "Run Nearest Test" },
        { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
        { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
        { "<leader>no", function() require("neotest").output_panel.toggle() end, desc = "Test Output Panel" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            },
        })
    end,
}
