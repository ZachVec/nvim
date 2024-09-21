return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
  end,
  config = function()
    local nnoremap = require("utils.keymapper").nnoremap
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- unmap keymaps
      vim.keymap.del("n", "<C-e>", { buffer = bufnr })

      -- custom mappings (for nvim-tree buffer only)
      nnoremap("?", api.tree.toggle_help, { desc = "nvim-tree: Help", buffer = bufnr, nowait = true })
      nnoremap("<C-t>", api.tree.change_root_to_parent, { desc = "nvim-tree: Up", buffer = bufnr, nowait = true })
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

    nnoremap("<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "nvim-tree: Toggle", nowait = true })
    nnoremap("<leader>r", "<cmd>NvimTreeFindFile<cr>", { desc = "nvim-tree: Reveal", nowait = true })
  end,
}
