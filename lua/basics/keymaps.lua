local nnoremap = require("utils.keymapper").nnoremap

nnoremap("<C-h>", "<C-w>h") -- navigate left
nnoremap("<C-j>", "<C-w>j") -- navigate down
nnoremap("<C-k>", "<C-w>k") -- navigate up
nnoremap("<C-l>", "<C-w>l") -- navigate right
nnoremap("gh", ":tabprevious<CR>") -- previous tab
nnoremap("gl", ":tabnext<CR>") -- next tab

-- Resize with windows
nnoremap("<M-k>", ":resize -2<CR>")
nnoremap("<M-j>", ":resize +2<CR>")
nnoremap("<M-h>", ":vertical resize -2<CR>")
nnoremap("<M-l>", ":vertical resize +2<CR>")

-- Swap lines
nnoremap("<M-DOWN>", "mz:m+<cr>`z")
nnoremap("<M-UP>", "mz:m-2<cr>`z")

local vnoremap = require("utils.keymapper").vnoremap
-- Hint: start visual mode with the same area as the previous area and the same mode
-- keyset('v', '<', '<gv', opts)
-- keyset('v', '>', '>gv', opts)

local inoremap = require("utils.keymapper").inoremap
inoremap("jj", "<ESC>")
