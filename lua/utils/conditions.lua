--- @type table<string, function>
local conditions = {}

function conditions.in_tmux() return os.getenv("TMUX") ~= nil end

function conditions.not_in_tmux() return not conditions.in_tmux() end

---check if plugin exists
---@param name string
---@return boolean
function conditions.has_plugin(name) return pcall(require, name) end

---check if plugin not exists
---@param name string
---@return boolean
function conditions.not_has_plugin(name) return not conditions.has_plugin(name) end

return conditions
