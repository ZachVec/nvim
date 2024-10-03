require("utils.keymap")
require("utils.config")

return UserConf:new("aerial", {}, {
  Keymap:new("n", ";f", "<CMD>AerialToggle! right<CR>", { desc = "List Functions/Classes/..." }),
})
