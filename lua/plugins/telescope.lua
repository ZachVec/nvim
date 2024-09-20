return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
    },
    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                    find_command = {"fd"},
                    layout_config = { width = 0.6 },
                },
                buffers = {
                    mappings = {
                        n = {
                            ["dd"] = "delete_buffer"
                        }
                    },
                    layout_config = { width = 0.6 },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                aerial = {
                    -- How to format the symbols
                    format_symbol = function(symbol_path, filetype)
                        if filetype == "json" or filetype == "yaml" then
                            return table.concat(symbol_path, ".")
                        else
                            return symbol_path[#symbol_path]
                        end
                    end,
                    -- Available modes: symbols, lines, both
                    show_columns = "both",
                },
                tabpicker = {
                    mappings = {
                        n = { ["dd"] = "close_tab" }
                    }
                }
            }
        }
        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')

        local aerial = require('telescope').load_extension('aerial')
        local tabpicker = require("telescope").load_extension("tabpicker")
        local function find_buffers () builtin.live_grep({grep_open_files = true}) end

        -- custom mappings 
        local nnoremap = require("utils").nnoremap
        nnoremap("<leader>ff", builtin.find_files)  -- find files
        nnoremap("<leader>fb", builtin.buffers)     -- find buffers
        nnoremap("<leader>ft", aerial.aerial)       -- find tags

        nnoremap("<leader>Ff", builtin.live_grep)   -- grep files
        nnoremap("<leader>Fb", find_buffers)        -- grep buffers
        nnoremap("<leader>Ft", builtin.tags)        -- grep tags (by CTAG)

        nnoremap("<leader>hs", builtin.search_history)   -- history of search
        nnoremap("<leader>hc", builtin.command_history)  -- history of command
        nnoremap("<leader>lt", tabpicker.find_tabpages)  -- list tabs
        nnoremap("<leader>lr", builtin.registers)        -- list registers
        nnoremap("<leader>lc", builtin.colorscheme)      -- list colorscheme
    end
}

