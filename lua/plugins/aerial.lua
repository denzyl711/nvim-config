return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial" },
    },
    opts = {
        layout = {
            min_width = 30,
            default_direction = "right",
        },
        filter_kind = false,
    },
}
