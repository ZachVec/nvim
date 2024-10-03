require("utils.keymap")
require("utils.config")

local actions = require("telescope.actions")
local conf = UserConf:new("telescope", {
  defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
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
  }),
  pickers = {
    find_files = {
      find_command = { "fd" },
    },
    buffers = {
      mappings = {
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
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
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
}, {
  Keymap:new("n", ";c", "<CMD>Telescope colorscheme<CR>", { desc = "List Colorschemes" }),
  Keymap:new("n", ";r", "<CMD>Telescope registers<CR>", { desc = "List Registers" }),
  Keymap:new("n", ";m", "<CMD>Telescope marks<CR>", { desc = "List Bookmarks" }),
  Keymap:new("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files by filename" }),
  Keymap:new("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Find buffers by filename" }),
  Keymap:new("n", "<leader>ft", "<CMD>Telescope tags<CR>", { desc = "Find tags via CTAG" }),
  Keymap:new("n", "<leader>fF", "<CMD>Telescope live_grep<CR>", { desc = "grep files" }),
  Keymap:new("n", "<leader>fB", "<CMD>Telescope live_grep grep_open_files=true<CR>", { desc = "grep buffers" }),
  Keymap:new("n", "<leader>fT", "<cmd>Telescope aerial<cr>", { desc = "Find tags via treesitter" }),
})

function conf:setup_else()
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("aerial")
end

return conf
