return {
  'folke/which-key.nvim',
  event = 'VimEnter',  -- load on startup
  opts = {
    delay = 100,  -- popup delay in ms
    icons = { mappings = vim.g.have_nerd_font }, -- use nerd font icons if available

    -- key documentation
    spec = (function()
      local s = {
        -- File & text search
        { '<leader>f', group = '[F]ind', mode = { 'n', 'v' } },  -- covers ff, fg

        -- Buffers
        { '<leader>bd', group = '[B]uffer [D]elete', mode = { 'n' } }, -- delete buffer mapping

        -- LSP actions
        { '<leader>D', group = 'Type Definition', mode = { 'n' } },
        { 'gd', group = 'Go to Definition', mode = { 'n' } },
        { 'gr', group = 'Go to References', mode = { 'n' } },
        { 'gD', group = 'Go to Global Definition', mode = { 'n' } },
        { '<leader>rn', group = 'Rename Symbol', mode = { 'n' } },           -- vim.lsp.buf.rename
        { '<leader>wa', group = 'Add Workspace Folder', mode = { 'n' } },    -- vim.lsp.buf.add_workspace_folder
        { '<leader>wr', group = 'Remove Workspace Folder', mode = { 'n' } }, -- vim.lsp.buf.remove_workspace_folder
        { '<leader>wl', group = 'List Workspace Folders', mode = { 'n' } },  -- vim.lsp.buf.list_workspace_folders
        { '<leader>ca', group = 'Code Action', mode = { 'n', 'v' } },        -- vim.lsp.buf.code_action

        -- Noice & UI toggles
        { '<leader>nd', group = 'Dismiss Notifications', mode = { 'n' } },
        { '<leader>sn', group = 'Show Line Numbers', mode = { 'n' } },

        -- Terminal (floaterm)
        { '<leader>t', group = '[T]erminal', mode = { 'n' } },
        { '<leader>tt', desc = 'New Terminal', mode = { 'n' } },
        { '<leader>td', desc = 'Kill Terminal', mode = { 'n' } },
        { '<leader>tk', desc = 'Next Terminal', mode = { 'n' } },
        { '<leader>tj', desc = 'Previous Terminal', mode = { 'n' } },
        { '<leader>tl', desc = 'Last Terminal', mode = { 'n' } },
        { '<leader>th', desc = 'First Terminal', mode = { 'n' } },

        -- Claude (AI)
        { '<leader>c', group = '[C]laude', mode = { 'n' } },
        { '<leader>cc', desc = 'Toggle Claude Code', mode = { 'n' } },
        { '<leader>cC', desc = 'Claude Continue', mode = { 'n' } },
        { '<leader>cr', desc = 'Claude Resume', mode = { 'n' } },

      }

      -- Hide <leader>1-9 (bufferline mappings) from WhichKey popup
      for i = 1, 9 do
        table.insert(s, { '<leader>'..i, hidden = true })
      end

      return s
    end)(),
  },
}
