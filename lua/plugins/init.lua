local opts = require("plugins.options")
local cond = require("utils.conditions")

return {
  { "ellisonleao/gruvbox.nvim", opts = opts.gruvbox, lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", opts = opts.tokyonight, lazy = false, priority = 1000 },
  { "j-hui/fidget.nvim", opts = opts.fidget },
  { "lukas-reineke/indent-blankline.nvim", opts = opts.ibl, main = "ibl" },
  { "nvim-treesitter/nvim-treesitter", opts = opts.nvim_treesitter, build = ":TSUpdate" },
  { "chentoast/marks.nvim", opts = opts.marks, event = "VeryLazy" },
  { "smoka7/hop.nvim", opts = opts.hop, version = "*" },
  { "lewis6991/gitsigns.nvim", opts = opts.gitsigns },
  { "echasnovski/mini.pairs", opts = opts.minipairs, version = "*" },
  { "aserowy/tmux.nvim", opts = opts.tmux, lazy = cond.not_in_tmux() },
  { "numToStr/Comment.nvim", opts = opts.Comment },
  { "williamboman/mason.nvim", opts = opts.mason },
  { "nvim-lualine/lualine.nvim", opts = opts.lualine, dependencies = { "nvim-tree/nvim-web-devicons" } },

  {
    "stevearc/aerial.nvim",
    opts = opts.aerial,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  {
    "stevearc/conform.nvim",
    init = function() vim.g.disable_autoformat = true end,
    opts = opts.conform,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = opts.mason_lspconfig,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = opts.nvim_tree,
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = opts.telescope,
  },

  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/conform.nvim",
      "lewis6991/gitsigns.nvim",
      "stevearc/aerial.nvim",
    },
    opts = opts.which_key,
  },

  require("plugins.cmp"),
}
