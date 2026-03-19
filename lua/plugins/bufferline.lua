return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      numbers = "ordinal",
      diagnostics = "nvim_lsp",
      offsets = {{filetype = "NvimTree", text = "File Explorer", padding = 1}},
 --     separator_style = "thin",
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)

    -- Map <leader>1-9 to jump to buffers 1-9
    for i = 1, 9 do
      vim.keymap.set('n', '<leader>'..i, function()
        require('bufferline').go_to_buffer(i, true)
      end)
    end
  end,
}
