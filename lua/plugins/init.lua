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
  { "folke/which-key.nvim", opts = opts.which_key },
  { "akinsho/toggleterm.nvim", opts = opts.toggleterm },

  { -- formatter
    "stevearc/conform.nvim",
    init = function() vim.g.disable_autoformat = true end,
    opts = opts.conform,
  },

  { -- lsp
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = opts.mason_lspconfig,
  },

  { -- file browser
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = opts.nvim_tree,
  },

  { -- telescopes
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    opts = opts.telescope,
  },

  { -- sorter
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function() require("telescope").load_extension("fzf") end,
  },

  { -- find tags in current doc & provide current context in winbar
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function() require("telescope").load_extension("aerial") end,
  },

  { -- change ui-select to telescope dropdown
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function() require("telescope").load_extension("ui-select") end,
  },

  { -- code completion
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      -- basic code completion
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- for luasnip code completion
      "L3MON4D3/LuaSnip",
      "L3MON4D3/cmp_luasnip",

      -- frequently used code snippets
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup(opts.cmp())
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
