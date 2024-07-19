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
            vim.keymap.set("n", "<leader>ef", function()
                local dir = vim.g.project_root;
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
            -- vim.api.nvim_set_option('updatetime', 300)
            vim.opt.updatetime = 300
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
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function ()
            local harpoon = require("harpoon")

            harpoon:setup({
            --     -- Setting up custom behavior for a list named "cmd"
            --     cmd = {
            --
            --         -- When you call list:add() this function is called and the return
            --         -- value will be put in the list at the end.
            --         --
            --         -- which means same behavior for prepend except where in the list the
            --         -- return value is added
            --         --
            --         -- @param possible_value string only passed in when you alter the ui manual
            --         add = function(possible_value)
            --             -- get the current line idx
            --             local idx = vim.fn.line(".")
            --
            --             -- read the current line
            --             local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
            --             if cmd == nil then
            --                 return nil
            --             end
            --
            --             return {
            --                 value = cmd,
            --                 context = {vim.g.project_root},
            --             }
            --         end,
            --
            --         --- This function gets invoked with the options being passed in from
            --         --- list:select(index, <...options...>)
            --         --- @param list_item {value: any, context: any}
            --         --- @param list { ... }
            --         --- @param option any
            --         select = function(list_item, list, option)
            --             -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
            --             vim.cmd(list_item.value)
            --         end
            --
            --     }
            })

            vim.keymap.set('n', "<leader>a", function () harpoon:list():add() end, {desc = "Add harpoon mark"})
            vim.keymap.set("n", "<leader>h", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Open harpoon list"})
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, {desc = "Open harpoon mark 1"})
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, {desc = "Open harpoon mark 2"})
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, {desc = "Open harpoon mark 3"})
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, {desc = "Open harpoon mark 4"})
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    }
}
