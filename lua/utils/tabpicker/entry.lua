---@class TabEntry
---@field id number
---@field iscurrent boolean
---@field filenames table<string>
local TabEntry = {}

TabEntry.__index = TabEntry

function TabEntry.new(id, iscurrent, filenames)
  local self = setmetatable({}, TabEntry)
  self.id = id
  self.iscurrent = iscurrent
  self.filenames = filenames or {}
  return self
end

---returns the formatted tab entry string
---@return string
function TabEntry:format()
  local default_name = "[No Name]"

  ---@type table<string>
  local filenames = {}

  for _, item in ipairs(self.filenames) do
    table.insert(filenames, item ~= "" and item or default_name)
  end
  local filename = table.concat(filenames, ", ")
  local suffix = self.iscurrent and " <-- current tab" or ""
  return string.format("%d: %s%s", self.id, filename, suffix)
end

---add filename to filenames
---@param filename string
function TabEntry:add_file(filename) table.insert(self.filenames, filename) end

---close the tab itself
function TabEntry:close() vim.api.nvim_command("tabclose " .. self.id) end

---returns current tab entries
---@return table<TabEntry>
function TabEntry.list(opts)
  opts = vim.tbl_deep_extend("force", {
    disabled = {
      buftypes = { "acwrite", "help", "nofile", "quickfix", "prompt" },
      filetypes = { "toggleterm" },
    },
  }, opts or {})

  local current_tab_id = vim.api.nvim_get_current_tabpage()
  local tab_entries = {}
  for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
    local tab = TabEntry.new(tabid, current_tab_id == tabid, {})
    local winids = vim.tbl_filter(function(winid)
      if vim.api.nvim_win_get_config(winid).relative == nil then return false end
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
      if vim.tbl_contains(opts.disabled.buftypes, buftype) then return false end
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
      if vim.tbl_contains(opts.disabled.filetypes, filetype) then return false end
      return true
    end, vim.api.nvim_tabpage_list_wins(tabid))
    for _, winid in ipairs(winids) do
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      tab:add_file(filename)
    end
    table.insert(tab_entries, tab)
  end
  return tab_entries
end

return TabEntry
