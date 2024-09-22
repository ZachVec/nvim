local setup_opts = {
  lua_ls = {
    settings = {
      Lua = {
        diagnositics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
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
