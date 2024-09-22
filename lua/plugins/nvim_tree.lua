return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
  end,
  config = function()
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

    require("nvim-tree").setup({
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
    })
  end,
}
