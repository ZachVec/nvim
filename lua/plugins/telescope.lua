return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
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
              ["dd"] = "delete_buffer",
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
    local aerial = require("telescope").load_extension("aerial")
    local builtin = require("telescope.builtin")

    -- custom mappings
    local nnoremap = require("utils.keymapper").nnoremap

    nnoremap("<leader>ff", builtin.find_files, { desc = "Find files in repo" })
    nnoremap("<leader>fb", builtin.buffers, { desc = "Find buffers in repo" })
    nnoremap("<leader>ft", builtin.tags, { desc = "Find tags in repo" })
    nnoremap("<leader>f<tab>", require("utils.tabpicker").find_tabpages, { desc = "Find tabs" })

    nnoremap("<leader>Ff", builtin.live_grep, { desc = "Grep files" })
    nnoremap("<leader>Fb", function() builtin.live_grep({ grep_open_files = true }) end, { desc = "Grep buffer" })

    nnoremap("<leader>jt", aerial.aerial, { desc = "jump to tags in document" })
    nnoremap("<leader>lr", builtin.registers, { desc = "List all registers" })
    nnoremap("<leader>lc", builtin.colorscheme, { desc = "List all colorschemes" })
  end,
}
