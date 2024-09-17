local setup_opts = {
    lua_ls = {
        settings = {
            Lua = {
                diagnositics = {
                    globals = {"vim"}
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            },
        }
    },
    pyright = {},
    clangd = {},
}

return {
    "neovim/nvim-lspconfig",
    config = function ()
        local lspconfig = require("lspconfig")
        for client, opts in pairs(setup_opts) do
            lspconfig[client].setup(opts)
        end

        local nnoremap = require("utils").nnoremap
        nnoremap("K",           vim.lsp.buf.hover)
        nnoremap("gd",          vim.lsp.buf.definition)
        nnoremap("gD",          vim.lsp.buf.declaration)
        nnoremap("gr",          vim.lsp.buf.references)
        nnoremap("<leader>a",   vim.lsp.buf.code_action)
        nnoremap("<F2>",        vim.lsp.buf.rename)
    end
}
