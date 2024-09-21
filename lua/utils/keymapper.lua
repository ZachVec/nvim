--- Create a key mapper
---@param mode string | string[]
---@param opts vim.keymap.set.Opts
---@return fun(keys: string, cmd: string|function, new_opts: vim.keymap.set.Opts|nil)
local function make_key_mapper(mode, opts)
  --- map keys to cmd
  --- @param keys string
  --- @param cmd string|function
  --- @param new_opts vim.keymap.set.Opts|nil
  --- @return nil
  local key_mapper = function(keys, cmd, new_opts)
    local final_ops = vim.tbl_deep_extend("force", opts, new_opts or {})
    return vim.keymap.set(mode, keys, cmd, final_ops)
  end
  return key_mapper
end

return {
  nmap = make_key_mapper("n", { remap = true, silent = true }),
  imap = make_key_mapper("i", { remap = true, silent = true }),
  vmap = make_key_mapper("i", { remap = true, silent = true }),
  nnoremap = make_key_mapper("n", { noremap = true, silent = true }),
  inoremap = make_key_mapper("i", { noremap = true, silent = true }),
  vnoremap = make_key_mapper("v", { noremap = true, silent = true }),
}
