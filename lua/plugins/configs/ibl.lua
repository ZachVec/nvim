require("utils.keymap")
require("utils.config")

return UserConf:new("ibl", {
  exclude = { filetypes = { "dashboard" } },
})
