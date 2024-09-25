local TabEntry = require("utils.tabpicker.entry")

local tabpicker = {}

---list all the tabs
---@param opts table the options of picker
function tabpicker.find_tabpages(opts)
  opts = opts or {}
  vim.ui.select(
    TabEntry.list(),
    {
      prompt = opts.prompt or "Tabs",
      kind = "Tab-Selector",
      ---return format string given tab entry
      ---@param item TabEntry
      ---@return string
      format_item = function(item) return item:format() end,
    },
    ---set the current tabpage to the selected one
    ---@param item TabEntry
    ---@return nil
    function(item)
      if item ~= nil then return vim.api.nvim_set_current_tabpage(item.id) end
    end
  )
end

---close the selected tabs within prompt bufnr
---@param bufnr number
function tabpicker.close_tab(bufnr)
  local state = require("telescope.actions.state")
  local picker = state.get_current_picker(bufnr)
  picker:delete_selection(function(entry) entry:close() end)
end

return tabpicker
