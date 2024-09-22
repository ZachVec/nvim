return setmetatable({
  hop = require("configs.hop"),
  lualine = require("configs.lualine"),
  bufferline = require("configs.bufferline"),
  nvim_treesitter = require("configs.nvim_treesitter"),
  mason_lspconfig = require("configs.mason_lspconfig"),
  conform = require("configs.conform"),
}, {
  __index = function(_, _) return {} end,
})
