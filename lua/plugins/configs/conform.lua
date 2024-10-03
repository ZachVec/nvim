require("utils.keymap")
require("utils.config")

return UserConf:new("conform", {
  formatters_by_ft = {
    python = { "isort", "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    json = { "jq" },
  },
}, {
  Keymap:new("n", "<F4>", function() require("conform").format() end, { desc = "Format Document" }),
})
