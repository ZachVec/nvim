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
            }
        }
        require('telescope').load_extension('fzf')

        -- custom mappings 
        local builtin = require('telescope.builtin')
        local nnoremap = require("utils").nnoremap
        nnoremap("<leader>ff", builtin.find_files)  -- jump to file
        -- nnoremap("<leader>fg", builtin.git_files)   -- jump to git file
        nnoremap("<leader>fb", builtin.buffers)     -- jump to buffer
        nnoremap("<leader>ft", builtin.tags)        -- jump to tag
        nnoremap("<leader>tt", builtin.treesitter)  -- jump to tag
        nnoremap("<leader>fr", builtin.registers)   -- jump to registers
        nnoremap("<leader>sf", builtin.live_grep)   -- find string in file
        nnoremap("<leader>sb", function() builtin.live_grep({grep_open_files = true}) end)  -- find string in buffer
        nnoremap("<leader>hs", builtin.search_history)
        nnoremap("<leader>hc", builtin.command_history)
        nnoremap("<leader>cs", builtin.colorscheme)

        -- require('telescope').load_extension('aerial')
        -- nnoremap("<leader>tt", require("telescope").extensions.aerial.aerial)        -- jump to tag
    end
}

