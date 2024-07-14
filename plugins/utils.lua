return {
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
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function ()
            local dap = require("dap")
            dap.adapters.godot = {
                type = "server",
                host = "127.0.0.1",
                port = 6006
            }
            dap.configurations.gdscript = {
                {
                    type = "godot",
                    request = "launch",
                    name = "Launche scene",
                    project = "${workspaceFolder}",
                    launch_scene = true,
                }
            }
        end
    },
}
