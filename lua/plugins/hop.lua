return {
  "smoka7/hop.nvim",
  version = "*",
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    local nmap = require("utils.keymapper").nmap
    nmap("<leader>j", "<cmd>HopChar2<cr>")
    nmap("f", "<cmd>HopChar1CurrentLineAC<cr>")
    nmap("F", "<cmd>HopChar1CurrentLineBC<cr>")
  end,
}
