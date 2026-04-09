local buff = 0

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>A",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Add to harpoon",
      },
      {
        "<C-e>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Harpoon menu",
      },
      {
        "<C-h>",
        function()
          local harpoon_list = require("harpoon"):list()
          local length = harpoon_list:length()
          if length == 0 then return end

          local current_file = vim.api.nvim_buf_get_name(0)
          local current_index = nil
          for i = 1, length do
            local item = harpoon_list:get(i)
            if item and item.value and vim.fn.fnamemodify(item.value, ":p") == current_file then
              current_index = i
              break
            end
          end

          if current_index == 1 or current_index == nil then
            current_index = length
          else
            current_index = current_index - 1
          end

          local file_to_open = harpoon_list:get(current_index).value
          vim.cmd("badd " .. file_to_open)
          vim.cmd("buffer " .. file_to_open)
        end,
        desc = "Previous harpoon",
      },
      {
        "<C-l>",
        function()
          local harpoon_list = require("harpoon"):list()
          local length = harpoon_list:length()
          if length == 0 then return end

          local current_file = vim.api.nvim_buf_get_name(0)
          local current_index = nil
          for i = 1, length do
            local item = harpoon_list:get(i)
            if item and item.value and vim.fn.fnamemodify(item.value, ":p") == current_file then
              current_index = i
              break
            end
          end

          if current_index == length or current_index == nil then
            current_index = 1
          else
            current_index = current_index + 1
          end

          local file_to_open = harpoon_list:get(current_index).value
          vim.cmd("badd " .. file_to_open)
          vim.cmd("buffer " .. file_to_open)
        end,
        desc = "Next harpoon",
      },
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup()
    end,
  },
}
