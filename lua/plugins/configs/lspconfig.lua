require("utils.keymap")
require("utils.config")

local conf = UserConf:new("lspconfig", {
  lua_ls = {
    settings = {
      Lua = {
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = "Replace",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = true,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
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
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = {
      fallbackFlags = { "-std=c++17" },
    },
  },
  protols = {},
})

function conf:setup_main()
  local lspconfig = require("lspconfig")
  for lsp, lspopts in pairs(self.opts or {}) do
    lspconfig[lsp].setup(vim.tbl_extend("force", lspopts, {
      --- Function called when LSP attaches to a buffer
      --- @param client table The LSP client
      --- @param bufnr number The buffer number
      on_attach = function(client, bufnr)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Document" })
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })

        -- inlay hints
        if client.supports_method("textDocument/inlayHint", { bufnr = bufnr }) then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
    }))
  end
end

return conf
