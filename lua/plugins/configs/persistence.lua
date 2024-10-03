require("utils.keymap")
require("utils.config")

return UserConf:new("persistence", {}, {
  Keymap:new("n", ";s", function() require("persistence").select() end, { desc = "List Sessions" }),
})
