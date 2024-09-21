return {
  "stevearc/conform.nvim",
  config = function()
    vim.g.disable_autoformat = true
    require("conform").setup({
      formatters_by_ft = {
        python = { "isort", "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    })
    local nnoremap = require("utils.keymapper").nnoremap
    nnoremap("<leader>m", require("conform").format)
  end,
}
