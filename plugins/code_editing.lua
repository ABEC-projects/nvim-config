return {
    {"mg979/vim-visual-multi"},
    {"gbprod/yanky.nvim", opts = {}},
    {
        "m4xshen/autoclose.nvim", opts = {
            keys = {
                ["("] = { escape = false, close = false, pair = "()" },
                ["["] = { escape = false, close = false, pair = "[]" },
                ["{"] = { escape = false, close = false, pair = "{}" },

                [">"] = { escape = false, close = false, pair = "<>" },
                [")"] = { escape = false, close = false, pair = "()" },
                ["]"] = { escape = false, close = false, pair = "[]" },
                ["}"] = { escape = false, close = false, pair = "{}" },

                ['"'] = { escape = false, close = false, pair = '""' },
                ["'"] = { escape = false, close = false, pair = "''" },
                ["`"] = { escape = false, close = false, pair = "``" },
            },
            options = {
                disabled_filetypes = { "text" },
                disable_when_touch = true,
                touch_regex = "[%w(%[{]",
                pair_spaces = false,
                auto_indent = true,
                disable_command_mode = true,
            }
        }
    },
    {
        'Exafunction/codeium.nvim',
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function ()
            require("codeium").setup()
        end
    },
    { "tpope/vim-surround", event = "BufEnter" },
    {
        "mbbill/undotree",
        lazy = false,
        config = function ()
            vim.keymap.set('n', '<leader>ut', ':UndotreeToggle<CR>', {desc = 'Toggle undo tree'})
        end
    },
}
