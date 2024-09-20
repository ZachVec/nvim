return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require("gitsigns").setup {}
        local nnoremap = require("utils").nnoremap
        nnoremap("<leader>gd", "<cmd>Gitsigns diffthis<cr>")            -- git diff
        nnoremap("<leader>gn", "<cmd>Gitsigns next_hunk<cr>")           -- git next hunk
        nnoremap("<leader>gN", "<cmd>Gitsigns prev_hunk<cr>")           -- git prev hunk
        nnoremap("<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")        -- git preview hunk
        nnoremap("<leader>gs", "<cmd> Gitsigns stage_hunk<cr>")         -- git stage hunk
        nnoremap("<leader>gu", "<cmd> Gitsigns undo_stage_hunk<cr>")    -- git unstage hunk
        nnoremap("<leader>gr", "<cmd> Gitsigns reset_hunk<cr>")         -- git reset hunk
    end
}
