return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>jl", ":Telescope jumplist<CR>", { silent = true, noremap = true, desc = "Jump List" })


      require("telescope").load_extension("ui-select")

      
      local function switch_colorscheme()
  local themes = vim.fn.getcompletion("", "color")  -- Get available colorschemes
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  local original_colorscheme = vim.g.colors_name  -- Save current colorscheme

  pickers.new({}, {
    prompt_title = "Switch Colorscheme",
    finder = finders.new_table({ results = themes }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry, _)
        vim.cmd("colorscheme " .. entry.value) -- Change theme in preview
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      -- Apply colorscheme when pressing <CR>
      map("i", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.cmd("colorscheme " .. selection[1])
        end
      end)

      -- Restore original colorscheme if <Esc> is pressed
      map("i", "<Esc>", function()
        actions.close(prompt_bufnr)
        vim.cmd("colorscheme " .. original_colorscheme)
      end)

      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("ColorschemePicker", switch_colorscheme, {})

    end,
  },
}
