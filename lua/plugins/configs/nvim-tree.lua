require("utils.keymap")
require("utils.config")

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

return UserConf:new("nvim-tree", {
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
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
}, {
  Keymap:new("n", "<C-n>", "<CMD>NvimTreeFindFileToggle<CR>", { desc = "NvimTreeToggle" }),
})
