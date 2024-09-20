return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({})
    local nnoremap = require("utils").nnoremap
    nnoremap("<leader>tt", "<cmd>AerialToggle! right<CR>")
  end,
}
