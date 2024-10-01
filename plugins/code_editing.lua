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
    { "tpope/vim-surround", event = "BufEnter" },
    {
        "mbbill/undotree",
        lazy = false,
        config = function ()
            vim.keymap.set('n', '<leader>ut', ':UndotreeToggle<CR>', {desc = 'Toggle undo tree'})
        end
    },
    {
        dir = "~/Dev/nvim-lua/html-utils/",
        name = "html-utils",
        ft = "html",
        config = function ()
            require("html-utils").setup()
        end
    },
    {
        "ABEC-projects/html-utils.nvim",
        ft = "html",
        enabled = false,
        config = function ()
            require("html-utils").setup()
        end
    }
}
