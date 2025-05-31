return {
    {
        "epwalsh/obsidian.nvim",
        enabled = false,
        version = "*",  -- recommended, use latest release instead of latest commit
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            require'obsidian'.setup({
                workspaces = {
                    {
                        name = "personal",
                        path = "~/vaults/personal",
                    },
                    {
                        name = "work",
                        path = "~/vaults/work",
                    },
                    {
                        name = "not personal",
                        path = "~/vaults/not-personal",
                    },
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "notes/dailies",
                    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                    template = nil
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 1,
                },
                mappings = {
                    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                    ["gf"] = {
                        action = function()
                            return require("obsidian").util.gf_passthrough()
                        end,
                        opts = { noremap = false, expr = true, buffer = true },
                    },
                    -- Toggle check-boxes.
                    ["<leader>ch"] = {
                        action = function()
                            return require("obsidian").util.toggle_checkbox()
                        end,
                        opts = { buffer = true },
                    },
                    -- Smart action depending on context, either follow link or toggle checkbox.
                    ["<cr>"] = {
                        action = function()
                            return require("obsidian").util.smart_action()
                        end,
                        opts = { buffer = true, expr = true },
                    },
                },
                new_notes_location = "notes_subdir",
                templates = {
                    folder = "~/Templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    -- A map for custom variables, the key should be the variable and the value a function
                    substitutions = {},
                },
                picker = {
                    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                    name = "telescope.nvim",
                    -- Optional, configure key mappings for the picker. These are the defaults.
                    -- Not all pickers support all mappings.
                    mappings = {
                        -- Create a new note from your query.
                        new = "<C-x>",
                        -- Insert a link to the selected note.
                        insert_link = "<C-l>",
                    },
                },
            })
        end
    },
    {
        "oflisback/obsidian-bridge.nvim",
        enabled = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function() require("obsidian-bridge").setup({
            obsidian_server_address = "http://localhost:27123",
            scroll_sync = false,
        })
        end,
        event = {
            "BufReadPre *.md",
            "BufNewFile *.md",
        },
        lazy = true,
    },
}
