local Entry = require("utils.tabpicker.entry")

local tabpicker = {}

---list all the tabs
---@param opts table the options of picker
function tabpicker.find_tabpages(opts)
  opts = opts or {}
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  pickers
    .new(opts, {
      preview = false,
      prompt_title = "Tabs",
      finder = finders.new_table({
        results = Entry.list(),
        entry_maker = function(entry)
          return {
            value = entry,
            display = function(self) return self.value:format() end,
            ordinal = tostring(entry.id),
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          vim.api.nvim_set_current_tabpage(entry.value.id)
        end)
        map("n", "dd", tabpicker.close_tab)
        return true
      end,
    })
    :find()
end

---close the selected tabs within prompt bufnr
---@param bufnr number
function tabpicker.close_tab(bufnr)
  local state = require("telescope.actions.state")
  local picker = state.get_current_picker(bufnr)
  picker:delete_selection(function(entry) entry:close() end)
end

return tabpicker
