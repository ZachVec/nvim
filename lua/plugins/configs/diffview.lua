require("utils.keymap")
require("utils.config")

return UserConf:new("diffview", {}, {
  Keymap:new("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "Diffview" }),
})
