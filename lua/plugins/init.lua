local cond = require("utils.conditions")

local function setup(name)
  local prefix = "plugins.configs."
  return function() require(prefix .. name):setup() end
end

return {
  { "ellisonleao/gruvbox.nvim", opts = {}, lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", opts = {}, lazy = false, priority = 1000 },
  { "j-hui/fidget.nvim", opts = {} },
  { "williamboman/mason.nvim", opts = {} },
  { "echasnovski/mini.pairs", opts = {}, version = "*" },
  { "chentoast/marks.nvim", opts = {}, event = "VeryLazy" },
  { "tzachar/local-highlight.nvim", opts = {}, init = function() vim.o.updatetime = 500 end },
  { "aserowy/tmux.nvim", opts = {}, cond = cond.in_tmux() },
  { "nvimdev/dashboard-nvim", opts = {}, dependencies = "nvim-tree/nvim-web-devicons" },

  { "folke/which-key.nvim", config = setup("which-key") },
  { "smoka7/hop.nvim", config = setup("hop"), version = "*", event = "VeryLazy" },
  { "akinsho/toggleterm.nvim", config = setup("toggleterm") },
  { "lewis6991/gitsigns.nvim", config = setup("gitsigns") },
  { "neovim/nvim-lspconfig", config = setup("lspconfig") },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = setup("ibl"),
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = setup("nvim-treesitter"),
    build = ":TSUpdate",
  },
  {
    "nvim-lualine/lualine.nvim",
    config = setup("lualine"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "sindrets/diffview.nvim",
    config = setup("gitsigns"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "stevearc/conform.nvim",
    init = function() vim.g.disable_autoformat = true end,
    config = setup("conform"),
  },
  {
    "folke/persistence.nvim",
    config = setup("persistence"),
    event = "BufReadPre",
  },

  {
    "stevearc/aerial.nvim",
    config = setup("aerial"),
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  {
    "nvim-tree/nvim-tree.lua",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    config = setup("nvim-tree"),
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-telescope/telescope.nvim",
    config = setup("telescope"),
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      -- basic code completion
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- for luasnip code completion engine
      "L3MON4D3/LuaSnip",
      "L3MON4D3/cmp_luasnip",

      -- frequently used code snippets
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = setup("nvim-cmp"),
  },
}
