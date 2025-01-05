
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
        opts = {},
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function ()

            local function to_exact_name(value)
                return "^" .. value .. "$"
            end
            local Path = require("plenary.path")
            local function normalize_path(buf_name, root)
                return Path:new(buf_name):make_relative(root)
            end

            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    key = function ()
                        local root = vim.g.project_root
                        if root == nil then
                            root = vim.loop.cwd()
                        end
                        return root
                    end
                },
                default = {

                    create_list_item = function (config, name)
                        name = name
                        or normalize_path(
                            vim.api.nvim_buf_get_name(
                            vim.api.nvim_get_current_buf()
                        ),
                            config.get_root_dir()
                        )


                        local bufnr = vim.fn.bufnr(name, false)

                        local pos = { 1, 0 }
                        if bufnr ~= -1 then
                            pos = vim.api.nvim_win_get_cursor(0)
                        end


                        return {
                            value = name,
                            context = {
                                row = pos[1],
                                col = pos[2],
                                buf_name = vim.api.nvim_buf_get_name(0),
                                root = vim.g.project_root or vim.loop.cwd()
                            },
                        }
                    end,

                    select = function(list_item, list, options)
                        if list_item == nil then
                            return
                        end

                        options = options or {}

                        if vim.g.project_root == nil then
                            vim.g.project_root = list_item.context.root
                        end

                        local dir = list_item.context.dir
                        if dir == nil then
                            dir = ""
                        end

                        local bufname = list_item.context.buf_name


                        local bufnr = vim.fn.bufnr(to_exact_name(bufname))
                        local set_position = false
                        if bufnr == -1 then -- must create a buffer!
                            set_position = true
                            bufnr = vim.fn.bufadd(bufname)
                        end
                        if not vim.api.nvim_buf_is_loaded(bufnr) then
                            vim.fn.bufload(bufnr)
                            vim.api.nvim_set_option_value("buflisted", true, {
                                buf = bufnr,
                            })
                        end

                        if options.vsplit then
                            vim.cmd("vsplit")
                        elseif options.split then
                            vim.cmd("split")
                        elseif options.tabedit then
                            vim.cmd("tabedit")
                        end

                        vim.api.nvim_set_current_buf(bufnr)

                        if set_position then

                            local row = list_item.context.row
                            local row_text =
                                vim.api.nvim_buf_get_lines(0, row - 1, row, false)

                            local col, err = pcall(function () return #row_text[1] end)
                            if err == nil then
                                if list_item.context.col > col then
                                    list_item.context.col = col
                                end

                                vim.api.nvim_win_set_cursor(0, {
                                    list_item.context.row or 1,
                                    list_item.context.col or 0,
                                })
                            end

                        end

                    end,
                }
            })

            vim.keymap.set('n', "<leader>sr", function () vim.g.project_root = vim.fn.getcwd() end, {desc = "Set project root"})
            vim.keymap.set('n', "<leader>a", function () harpoon:list():add() end, {desc = "Add harpoon mark"})
            vim.keymap.set("n", "<leader>h", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Open harpoon list"})
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, {desc = "Open harpoon mark 1"})
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, {desc = "Open harpoon mark 2"})
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, {desc = "Open harpoon mark 3"})
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, {desc = "Open harpoon mark 4"})
        end
    },
    {
        enabled = true,
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            max_lines = 4,
            trim_scope = 'inner',
        },
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        config = function()
            require('hop').setup {
                keys = 'etovxqpdygfblzhckisuran'
            }
            local hop = require('hop')
            local directions = require('hop.hint').HintDirection
            vim.keymap.set('n', 'hf', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
            end, {remap=true})
            vim.keymap.set('n', 'hF', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
            end, {remap=true})
            vim.keymap.set('n', 'ht', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
            end, {remap=true})
            vim.keymap.set('n', 'hT', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
            end, {remap=true})
        end
    }
}

