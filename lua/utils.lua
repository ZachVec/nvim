--- @type fun(mode: string, opts: vim.keymap.set.Opts): fun(keys: string, cmd: function | string, updated: nil | vim.keymap.set.Opts)
local function make_key_mapper(mode, opts)
    local keyset = vim.keymap.set
    opts = vim.deepcopy(opts)

    --- @type fun(keys: string, cmd: function | string, updated: nil | vim.keymap.set.Opts)
    local key_mapper = function(keys, cmd, updated)
        if updated == nil then
            return keyset(mode, keys, cmd, opts)
        end
        local final_opts = vim.deepcopy(opts)
        for k, v in pairs(updated) do
            final_opts[k] = v
        end
        return keyset(mode, keys, cmd, final_opts)
    end
    return key_mapper
end


return {
    nmap = make_key_mapper("n", {remap=true, silent=true}),
    imap = make_key_mapper("i", {remap=true, silent=true}),
    vmap = make_key_mapper("i", {remap=true, silent=true}),
    nnoremap = make_key_mapper("n", {noremap=true, silent=true}),
    inoremap = make_key_mapper("i", {noremap=true, silent=true}),
    vnoremap = make_key_mapper("v", {noremap=true, silent=true}),
}




