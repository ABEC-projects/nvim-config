return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            vim.keymap.set("n", "<leader>es", function()
                local cwd = vim.fn.getcwd()
                vim.cmd("let g:open_neotree_at='"..cwd.."'")
            end, {desc = "Set neotree root"})

            vim.keymap.set("n", "<leader>eS", function()
                if vim.g.open_neotree_at ~= nil then
                    vim.cmd("unlet g:open_neotree_at")
                end
            end, {desc = "Unset neotree root as cwd"})

            vim.keymap.set("n", "<leader>ef", function()
                local dir = vim.g.open_neotree_at;
                if dir == nil then
                    dir = vim.fn.getcwd()
                end
                vim.cmd("Neotree dir="..dir.."")
            end, {desc="Open NeoTree"})

            vim.keymap.set("n", "<leader>ec", function()
                vim.cmd("Neotree action=close")
            end, {desc="Close NeoTree"})
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", },
        opts = {},
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            triggers_blacklist = {
                [":"] = {"w"},
            },
        },
    },
    {
        "hadronized/hop.nvim",
        opts = {},
        enabled = false,
        config = function()
            local hop = require('hop')
            local directions = require('hop.hint').HintDirection
            vim.keymap.set('', 'f', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
            end, {remap=true})
            vim.keymap.set('', 'F', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
            end, {remap=true})
            vim.keymap.set('', 't', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
            end, {remap=true})
            vim.keymap.set('', 'T', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
            end, {remap=true})
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set('n', "<leader>a", function () harpoon:list():add() end)
            vim.keymap.set("n", "<leader>H", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        end
    },
}
