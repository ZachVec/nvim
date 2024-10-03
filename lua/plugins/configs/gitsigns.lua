require("utils.keymap")
require("utils.config")

return UserConf:new("gitsigns", {}, {
  Keymap:new("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diffthis" }),
  Keymap:new("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" }),
  Keymap:new("n", "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" }),
  Keymap:new("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" }),
  Keymap:new("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" }),
  Keymap:new("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage hunk" }),
  Keymap:new("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" }),
})
