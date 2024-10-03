require("utils.keymap")
require("utils.config")

return UserConf:new("hop", {
  keys = "etovxqpdygfblzhckisuran",
}, {
  Keymap:new("n", "f", "<CMD>HopChar1CurrentLineAC<CR>", { desc = "Find word forward by leading character" }),
  Keymap:new("n", "F", "<CMD>HopChar1CurrentLineBC<CR>", { desc = "Find word backward by leading character" }),
  Keymap:new("n", "gw", "<CMD>HopChar2<CR>", { desc = "Goto words in current window" }),
})
