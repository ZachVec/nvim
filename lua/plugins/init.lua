local opts = require("configs")
local cond = require("utils.conditions")

return {
  -- visual
  { "ellisonleao/gruvbox.nvim", opts = opts.gruvbox, lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", opts = opts.tokyonight, lazy = false, priority = 1000 },
  { "j-hui/fidget.nvim", opts = opts.fidget },
  { "lukas-reineke/indent-blankline.nvim", opts = opts.ibl, main = "ibl" },
  { "nvim-treesitter/nvim-treesitter", opts = opts.nvim_treesitter, build = ":TSUpdate" },
  { "nvim-lualine/lualine.nvim", opts = opts.lualine, dependencies = "nvim-tree/nvim-web-devicons" },

  {
    "stevearc/aerial.nvim",
    opts = opts.aerial,
    keys = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  {
    "stevearc/conform.nvim",
    init = function() vim.g.disable_autoformat = true end,
    opts = opts.conform,
  },

  -- git stuff
  { "lewis6991/gitsigns.nvim", opts = opts.gitsigns },

  -- auto pair
  { "echasnovski/mini.pairs", opts = opts.minipairs, version = "*" },

  -- navigate between tmux & nvim
  { "aserowy/tmux.nvim", opts = opts.tmux, lazy = cond.not_in_tmux },

  -- block & line comments
  { "numToStr/Comment.nvim", opts = opts.Comment },

  -- PKG manager
  { "williamboman/mason.nvim", opts = opts.mason },

  -- LSP server installer
  { "williamboman/mason-lspconfig.nvim", opts = opts.mason_lspconfig },

  { "smoka7/hop.nvim", version = "*", opts = opts.hop },

  { "neovim/nvim-lspconfig" },

  -- FileExplorer
  require("plugins.nvim_tree"),

  -- Navigator
  require("plugins.telescope"),

  -- code completion
  require("plugins.cmp"),
}
