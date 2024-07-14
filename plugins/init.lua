return {
    {"folke/neoconf.nvim", cmd = "Neoconf", opts = {}},
    { "williamboman/mason.nvim", opts = {}},
    {"folke/neodev.nvim", opts = {}},
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
        config = function ()
            vim.cmd.aug("rust_keys")
            vim.api.nvim_create_autocmd(
                "BufEnter",
                {
                    group = "rust_keys",
                    pattern = "*.rs",
                    callback = function()
                        local buf = vim.api.nvim_get_current_buf()
                        local opts = {
                            buffer = buf,
                        }
                        vim.keymap.set("n", "<leader>ra", function ()
                            vim.cmd.RustLsp("codeAction")
                        end, opts)
                    end
                }
            )
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false
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
        enabled = false,
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
