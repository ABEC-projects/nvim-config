return {
    {"folke/neoconf.nvim", cmd = "Neoconf", opts = {}},
    -- Rust-Tools
    {"simrat39/rust-tools.nvim"},
    -- Mason
    { "williamboman/mason.nvim", opts = {}},
    -- Neodev
    {"folke/neodev.nvim", opts = {}},
    -- Commenting
    {
        "numToStr/Comment.nvim",
        opts = { },
        lazy = false
    },
    {
        'stevearc/oil.nvim',
        opts = {
            columns = {
                "icon",
                "mtime",
            },
            view_options = {show_hidden = true,},
            keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-s>s"] = "actions.select_vsplit",
                    ["<C-s>v"] = "actions.select_split",
                    ["<C-s>t"] = "actions.select_tab",
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-s>r"] = "actions.refresh",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = "actions.tcd",
                    ["gs"] = "actions.change_sort",
                    ["gx"] = "actions.open_external",
                    ["g."] = "actions.toggle_hidden",
                    ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
        },
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        dir = "~/Dev/nvim-lua/m3u_metadata/",
        name = "m3u_metadata",
        ft = "m3u",
        config = function ()
            require("m3u_metadata").setup({
                root_dir = "/home/abec/Music/external/"
            })
        end
    },
    {
        "andweeb/presence.nvim",
        config = function ()
            require("presence").setup({
                -- General options
                auto_update         = true,
                neovim_image_text   = "The One True Text Editor",
                main_image          = "neovim",
                client_id           = "793271441293967371",
                log_level           = nil,
                debounce_timeout    = 10,
                enable_line_number  = false,
                blacklist           = {},
                buttons             = true,
                file_assets         = {},
                show_time           = true,


                editing_text        = "Editing %s",
                file_explorer_text  = "Browsing %s",
                git_commit_text     = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text        = "Reading %s",
                workspace_text      = "Working on %s",
                line_number_text    = "Line %s out of %s",
            })
        end
    },
}
