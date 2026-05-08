return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>a",
            function()
                require("aerial").toggle()
                if require("aerial").is_open() then
                    require("aerial").focus()
                end
            end,
            desc = "Toggle Aerial (focus)",
        },
        {
            "<leader>A",
            "<cmd>AerialToggle!<cr>",
            desc = "Toggle Aerial (no focus)",
        },
    },
    opts = {
        layout = {
            min_width = 30,
            default_direction = "right",
        },
        filter_kind = false,
        -- Close aerial and jump to selected symbol
        close_on_select = true,
    },
}
