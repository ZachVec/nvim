---@class (exact) Keymap
---@field mode string | string[]
---@field lhs string
---@field rhs string | function
---@field opts table?
---@field __index table
Keymap = {
  mode = "n",
  lhs = "",
  rhs = "",
  opts = nil,
}
Keymap.__index = Keymap

---Construct a new keymap
---@param mode string
---@param lhs string | string[]
---@param rhs string | function
---@param opts table?
function Keymap:new(mode, lhs, rhs, opts)
  local keymap = setmetatable({}, Keymap)
  keymap.mode = mode
  keymap.lhs = lhs
  keymap.rhs = rhs
  keymap.opts = opts
  return keymap
end

function Keymap:setup() vim.keymap.set(self.mode, self.lhs, self.rhs, self.opts) end
