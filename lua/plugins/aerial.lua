return {
    'stevearc/aerial.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        require("aerial").setup({})
        local nnoremap = require("utils").nnoremap
        nnoremap("<leader>tl", "<cmd>AerialToggle! right<CR>")
        nnoremap("<leader>tr", "<cmd>AerialToggle! left<CR>")
        nnoremap("<leader>tf", "<cmd>AerialToggle float<CR>")
    end
}
