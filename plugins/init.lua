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
        enabled = false,
        config = function ()
            require("m3u_metadata").setup({
                root_dir = "/home/abec/Music/external/"
            })
        end
    },
}
