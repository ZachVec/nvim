local cond = require("utils.conditions")

return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = false,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          z = false,
          g = false,
        },
      },
    })

    local telescope = require("telescope.builtin")

    -- insert mode
    wk.add({
      { "jj", "<ESC>", desc = "Escape", mode = "i" },
    })

    -- visual mode
    wk.add({
      { "<M-DOWN>", "mz:m+<cr>`z", desc = "Swap line downwards", mode = "v" },
      { "<M-UP>", "mz:m-2<cr>`z", desc = "Swap line upwards", mode = "v" },
    })

    -- normal mode
    if cond.not_has_plugin("tmux.nvim") then
      -- the keymaps below has already be set by tmux.nvim
      wk.add({
        { "<C-h>", "<C-w>h", desc = "Navigate to window on the left" },
        { "<C-j>", "<C-w>j", desc = "Navigate to window on the bottom" },
        { "<C-k>", "<C-w>k", desc = "Navigate to window on the top" },
        { "<C-l>", "<C-w>l", desc = "Navigate to window on the right" },
      })
    end

    wk.add({
      { "K", vim.lsp.buf.hover, desc = "Show Document" },
      { "f", "<cmd>HopChar1CurrentLineAC<cr>", desc = "find word forward by leading character" },
      { "F", "<cmd>HopChar1CurrentLineBC<cr>", desc = "find word backward by leading character" },
      { "<F2>", vim.lsp.buf.rename, desc = "rename variable" },
      { "<F3>", vim.lsp.buf.code_action, desc = "code action" },
      { "<F4>", require("conform").format, desc = "Format document" },
      { '"', telescope.registers, desc = "Lookup registers" },

      { "<C-n>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTreeToggle" },
      { "<C-m>", "<cmd>AerialToggle! right<cr>", desc = "AerialToggle" },

      -- Group: List
      { ";", group = "List someting?" },
      { ";c", telescope.colorscheme, desc = "List colorschemes" },
      { ";t", require("utils.tabpicker").find_tabpages, desc = "List tabs" },

      -- Group: Go to
      { "g", group = "Go to ..." },
      { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
      { "gr", vim.lsp.buf.references, desc = "Go to references" },
      { "gw", "<cmd>HopChar2<cr>", desc = "Go to words in current window" },
      { "gh", "<cmd>tabprevious<cr>", desc = "Go to previous tab" },
      { "gl", "<cmd>tabnext<cr>", desc = "Go to next tab" },

      -- Group: Find
      { "<leader>f", group = "Find" },
      { "<leader>ff", telescope.find_files, desc = "Find files by filename" },
      { "<leader>fb", telescope.buffers, desc = "Find buffers by filename" },
      { "<leader>ft", telescope.tags, desc = "Find tags via CTAG" },
      { "<leader>fF", telescope.live_grep, desc = "grep files" },
      {
        "<leader>fB",
        function() telescope.live_grep({ grep_open_files = true }) end,
        desc = "grep buffers",
      },
      { "<leader>fT", "<cmd>Telescope aerial<cr>", desc = "Find tags via treesitter" },

      -- Group: Git
      { "<leader>g", group = "Git with gitsigns" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff current file" },
      { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
      { "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    })
  end,
}
