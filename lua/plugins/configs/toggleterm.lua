require("utils.keymap")
require("utils.config")

return UserConf:new("toggleterm", {
  winbar = {
    enabled = true,
    name_formatter = function(term) return "Terminal #" .. term.id end,
  },
}, {
  Keymap:new("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape" }),
  Keymap:new("t", "<F12>", "<CMD>ToggleTerm<CR>", { desc = "Toggle Terminal" }),
  Keymap:new("n", "<F12>", "<CMD>ToggleTerm<CR>", { desc = "Toggle Terminal" }),
  Keymap:new("n", ";t", "<CMD>TermSelect<CR>", { desc = "List Terminals" }),
})
