return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          find_command = { "fd" },
          layout_config = { width = 0.6 },
        },
        buffers = {
          mappings = {
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
          layout_config = { width = 0.6 },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        aerial = {
          -- How to format the symbols
          format_symbol = function(symbol_path, filetype)
            if filetype == "json" or filetype == "yaml" then
              return table.concat(symbol_path, ".")
            else
              return symbol_path[#symbol_path]
            end
          end,
          -- Available modes: symbols, lines, both
          show_columns = "both",
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("aerial")
  end,
}
