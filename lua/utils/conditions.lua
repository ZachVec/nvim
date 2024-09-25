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

---check if buffer is empty
---@return boolean
function conditions.buffer_empty() return vim.fn.empty(vim.fn.expand("%:t")) == 1 end

---check if buffer is not empty
---@return boolean
function conditions.not_buffer_empty() return not conditions.buffer_empty() end

---chech if plugin has loaded
---@param name string
---@return boolean
function conditions.loaded(name) return package.loaded[name] ~= nil end

---chech if plugin has not loaded
---@param name string
---@return boolean
function conditions.not_loaded(name) return not conditions.loaded(name) end

return conditions
