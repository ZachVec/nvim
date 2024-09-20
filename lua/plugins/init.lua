local opts = setmetatable({
  nvim_treesitter = {
    ensure_installed = { "c", "cpp", "lua", "python", "markdown", "markdown_inline", "vim", "vimdoc" },
  },
  bufferline = {
    options = {
      mode = "tabs",
      offsets = { { filetype = "NvimTree", text = "FileExplorer", separator = true, text_align = "left" } },
    },
  },
  mason_lspconfig = { ensure_installed = { "lua_ls", "pyright", "clangd" } },
}, {
  __index = function(_, _) return {} end,
})

local cond = {
  not_in_tmux = function() return os.getenv("TMUX") == nil end,
}

return {
  -- visual
  { "ellisonleao/gruvbox.nvim", opts = opts.gruvbox, lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", opts = opts.tokyonight, lazy = false, priority = 1000 },
  { "j-hui/fidget.nvim", opts = opts.fidget },
  { "lukas-reineke/indent-blankline.nvim", opts = opts.ibl, main = "ibl" },
  { "nvim-treesitter/nvim-treesitter", opts = opts.nvim_treesitter, build = ":TSUpdate" },

  -- auto pair
  { "echasnovski/mini.pairs", opts = opts.minipairs, version = "*" },

  -- navigate between tmux & nvim
  { "aserowy/tmux.nvim", opts = opts.tmux, lazy = cond.not_in_tmux() },

  -- block & line comments
  { "numToStr/Comment.nvim", opts = opts.Comment },

  -- PKG manager
  { "williamboman/mason.nvim", opts = opts.mason },

  -- LSP server installer
  { "williamboman/mason-lspconfig.nvim", opts = opts.mason_lspconfig },

  -- tabpicker
  { "ZachVec/tabpicker.nvim", opts = opts.tabpicker },

  -- gitsigns
  require("plugins.gitsigns"),

  -- tabline & winbar & statusline
  require("plugins.lualine"),

  -- tags outline
  require("plugins.aerial"),

  -- LSP setups & keymaps
  require("plugins.lspconfig"),

  -- Formatters
  require("plugins.conform"),

  -- FileExplorer
  require("plugins.nvim_tree"),

  -- Navigator
  require("plugins.telescope"),

  -- Hop around
  require("plugins.hop"),

  -- code completion
  require("plugins.cmp"),
}
