local cond = require("utils.conditions")

--- @type table<string, table | function>
local options = setmetatable({}, { __index = function(_, _) return {} end })

options.hop = {
  keys = "etovxqpdygfblzhckisuran",
}

options.lualine = (function()
  local comp = {
    mode = "mode",
    icon = {
      "filetype",
      colored = true,
      icon_only = true,
    },
    filepath = {
      "filename",
      file_status = true, -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory 4: Filename and parent dir, with tilde as the home directory
      shorting_target = 60, -- Shortens path to leave 40 spaces in the window
      symbols = {
        modified = "[+]", -- Text to show when the file is modified.
        readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[No Name]", -- Text to show for unnamed buffers.
        newfile = "[New]", -- Text to show for newly created file before first write
      },
      cond = cond.not_buffer_empty,
    },
    aerial = "aerial",
    branch = "branch",
    diff = "diff",
    diagnostics = "diagnostics",
    encoding = "encoding",
    fileformat = "fileformat",
    filetype = "filetype",
    progress = "progress",
    location = "location",
    section = "%=",
    lsp_server = {
      function()
        local msg = "No Active Lsp"
        local bufnr = vim.fn.bufnr("%")
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if next(clients) == nil then return msg end
        return clients[1].name
      end,
      icon = " LSP:",
    },
    tabs = "tabs",
  }
  return {
    options = {
      disabled_filetypes = { "NvimTree", "aerial" },
      component_separators = "",
    },
    sections = {
      lualine_a = {}, -- {comp.mode},
      lualine_b = {}, -- {comp.branch, comp.diff},
      lualine_c = {}, -- {comp.section, comp.lsp_server},
      lualine_x = { comp.lsp_server, comp.diagnostics }, -- {},
      lualine_y = { comp.encoding, comp.filetype }, -- {comp.diagnostics, comp.encoding, comp.filetype},
      lualine_z = { comp.progress, comp.location }, -- {comp.progress, comp.location},
    },
    inactive_sections = {
      lualine_a = {}, -- {comp.mode},
      lualine_b = {}, -- {comp.branch, comp.diff},
      lualine_c = {}, -- {comp.section, comp.lsp_server},
      lualine_x = { comp.lsp_server, comp.diagnostics }, -- {},
      lualine_y = { comp.encoding, comp.filetype }, -- {comp.diagnostics, comp.encoding, comp.filetype},
      lualine_z = { comp.progress, comp.location }, -- {comp.progress, comp.location},
    },
    winbar = {
      lualine_a = {},
      lualine_b = { comp.filepath, comp.aerial },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = { comp.filepath, comp.aerial },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = { comp.tabs },
      lualine_b = { comp.branch, comp.diff },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "aerial", "lazy", "mason", "nvim-tree" },
  }
end)()

options.bufferline = {
  options = {
    mode = "tabs",
    offsets = { { filetype = "NvimTree", text = "FileExplorer", separator = true, text_align = "left" } },
  },
}

options.nvim_treesitter = {
  ensure_installed = { "c", "cpp", "lua", "python", "markdown", "markdown_inline", "vim", "vimdoc" },
}

options.mason_lspconfig = function()
  local setup_opts = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnositics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("lua/", true),
          },
        },
      },
    },
    pyright = {},
    -- clangd = {},
  }
  local handlers = {}
  for client, opts in pairs(setup_opts) do
    handlers[client] = function() require("lspconfig")[client].setup(opts) end
  end
  return {
    ensure_installed = { "lua_ls", "pyright", "clangd" },
    handlers = handlers,
  }
end

options.conform = {
  formatters_by_ft = {
    python = { "isort", "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
  },
}

options.nvim_tree = function()
  local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- unmap keymaps
    vim.keymap.del("n", "<C-e>", { buffer = bufnr })

    -- custom mappings (for nvim-tree buffer only)
    vim.keymap.set("n", "?", api.tree.toggle_help, { desc = "nvim-tree: Help", buffer = bufnr, nowait = true })
    vim.keymap.set(
      "n",
      "<C-t>",
      api.tree.change_root_to_parent,
      { desc = "nvim-tree: Up", buffer = bufnr, nowait = true }
    )
  end
  return {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
    on_attach = on_attach,
  }
end

options.telescope = function()
  local actions = require("telescope.actions")
  return {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        },
        n = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        find_command = { "fd" },
        layout_config = { width = 0.6 },
      },
      buffers = {
        mappings = {
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
        layout_config = { width = 0.6 },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      aerial = {
        -- How to format the symbols
        format_symbol = function(symbol_path, filetype)
          if filetype == "json" or filetype == "yaml" then
            return table.concat(symbol_path, ".")
          else
            return symbol_path[#symbol_path]
          end
        end,
        -- Available modes: symbols, lines, both
        show_columns = "both",
      },
    },
  }
end

options.which_key = function()
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("aerial")

  local telescope = require("telescope.builtin")
  local config = {}
  config.plugins = {
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
  }
  config.spec = {
    -- insert mode
    { "jj", "<ESC>", desc = "Escape", mode = "i" },

    -- visual mode
    { "<M-DOWN>", "mz:m+<cr>`z", desc = "Swap line downwards", mode = "v" },
    { "<M-UP>", "mz:m-2<cr>`z", desc = "Swap line upwards", mode = "v" },

    -- normal mode
    { "K", vim.lsp.buf.hover, desc = "Show Document" },
    { "f", "<cmd>HopChar1CurrentLineAC<cr>", desc = "find word forward by leading character" },
    { "F", "<cmd>HopChar1CurrentLineBC<cr>", desc = "find word backward by leading character" },
    { "<F2>", vim.lsp.buf.rename, desc = "rename variable" },
    { "<F3>", vim.lsp.buf.code_action, desc = "code action" },
    { "<F4>", require("conform").format, desc = "Format document" },

    { "<C-n>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTreeToggle" },
    { "<C-m>", "<cmd>AerialToggle! right<cr>", desc = "AerialToggle" },

    -- Group: List
    { ";", group = "List someting?" },
    { ";c", telescope.colorscheme, desc = "List colorschemes" },
    { ";t", require("utils.tabpicker").find_tabpages, desc = "List tabs" },
    { ';r', telescope.registers, desc = "List registers" },
    { ';b', telescope.marks, desc = "List bookmarks" },

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
  }
  if cond.not_has_loaded("tmux") then
    table.insert(config.spec, { "<C-h>", "<C-w>h", desc = "Navigate to window on the left" })
    table.insert(config.spec, { "<C-j>", "<C-w>j", desc = "Navigate to window on the bottom" })
    table.insert(config.spec, { "<C-k>", "<C-w>k", desc = "Navigate to window on the top" })
    table.insert(config.spec, { "<C-l>", "<C-w>l", desc = "Navigate to window on the right" })
  end

  return config
end

return options
