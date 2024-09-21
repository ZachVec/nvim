local TabEntry = {}

TabEntry.__index = TabEntry

function TabEntry:new(opts)
  opts = opts or {}
  local obj = setmetatable({
    id = opts.id or 0,
    iscurrent = opts.iscurrent or false,
    filenames = opts.filenames or {},
  }, self)
  return obj
end

function TabEntry:format()
  local default_name = "[No Name]"
  local filenames = {}
  for _, item in ipairs(self.filenames) do
    table.insert(filenames, item ~= "" and item or default_name)
  end
  local filename = table.concat(filenames, ", ")
  return string.format("%d: %s%s", self.id, filename, self.iscurrent and " <" or "")
end

--- add filename to filenames
---@param filename string
function TabEntry:add_file(filename) table.insert(self.filenames, filename) end

---close the tab itself
function TabEntry:close() vim.api.nvim_command("tabclose " .. self.id) end

function TabEntry.list()
    local current_tab_id = vim.api.nvim_get_current_tabpage()
    local tab_entries = {}
    for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
        local tab = TabEntry:new({ id = tabid, iscurrent = current_tab_id == tabid })
        local winids = vim.tbl_filter(
            function(winid) return vim.api.nvim_win_get_config(winid).relative ~= nil end,
            vim.api.nvim_tabpage_list_wins(tabid)
        )
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
