local cond = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
}

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
    cond = cond.buffer_not_empty,
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

local opts = {
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

-- return { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons", opts = opts}
return opts
