return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("illuminate").configure({
            delay = 200,
            filetypes_denylist = {
                "neo-tree",
                "Trouble",
                "lazy",
            },
        })
    end,
}
