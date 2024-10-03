require("utils.keymap")
require("utils.config")

return UserConf:new("nvim-treesitter.configs", {
  ensure_installed = { "c", "cpp", "lua", "python", "markdown", "markdown_inline", "vim", "vimdoc" },
})
