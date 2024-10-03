--- @class (exact) UserConf
--- @field main string
--- @field keys Keymap[]
--- @field opts table?
--- @field __index table
UserConf = {
  main = "Default UserConf",
  opts = nil,
  keys = {},
}
UserConf.__index = UserConf

---Create a new configuration for plugin `main`
---@param main string
---@param opts table?
---@param keys Keymap | Keymap[]?
---@return UserConf
function UserConf:new(main, opts, keys)
  local obj = setmetatable({}, UserConf)
  obj.main = main
  obj.opts = opts
  obj.keys = keys or {}
  return obj
end

---Create keymap
---@param keymap Keymap | Keymap[]
---@return UserConf
function UserConf:add_keymap(keymap)
  if type(keymap) ~= "table" then error("Not a keymap!", 2) end
  if #keymap == 0 then
    table.insert(self.keys, keymap)
    return self
  end

  for _, v in ipairs(keymap) do
    table.insert(self.keys, v)
  end
  return self
end

function UserConf:setup_main()
  if self.opts ~= nil then require(self.main).setup(self.opts) end
end

function UserConf:setup_else() end

function UserConf:setup_keys()
  for _, keymap in ipairs(self.keys) do
    keymap:setup()
  end
end

---run setup main, keymaps and else
---@return UserConf
function UserConf:setup()
  self:setup_main()
  self:setup_else()
  self:setup_keys()
  return self
end
