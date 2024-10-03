require("utils.keymap")
require("utils.config")
local cond = require("utils.conditions")

return UserConf:new("which-key", {
  plugins = {
    marks = false,
    registers = false,
    spelling = {
      enabled = false,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      z = false,
      g = false,
    },
  },
  spec = {
    { ";", group = "List Something?" },
    { "g", group = "Goto Somewhere?" },
    { "<leader>f", group = "Find Something?" },
    { "<leader>g", group = "Git operations" },

    -- extra keymaps
    { "jj", "<ESC>", desc = "Escape", mode = "i" },
    { ";<TAB>", require("utils.tabpicker").find_tabpages, desc = "List Tabs" },
    { "gh", "<cmd>tabprevious<cr>", desc = "Go to previous tab" },
    { "gl", "<cmd>tabnext<cr>", desc = "Go to next tab" },
    { "<C-h>", "<C-w>h", desc = "Navigate to window on the left", cond = cond.not_in_tmux },
    { "<C-j>", "<C-w>j", desc = "Navigate to window on the bottom", cond = cond.not_in_tmux },
    { "<C-k>", "<C-w>k", desc = "Navigate to window on the top", cond = cond.not_in_tmux },
    { "<C-l>", "<C-w>l", desc = "Navigate to window on the right", cond = cond.not_in_tmux },
  },
})
