local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    -- Neoconf 
    {"folke/neoconf.nvim", cmd = "Neoconf", opts = {}},
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
    -- Rust-Tools
    {"simrat39/rust-tools.nvim"},
    -- Mason
    { "williamboman/mason.nvim", opts = {}},
    -- Mason Lspconfig
    {"williamboman/mason-lspconfig.nvim", opts = {}},
    -- Nvim Treesitter
    {"nvim-treesitter/nvim-treesitter", opts = {}},
    -- Yanky
    {"gbprod/yanky.nvim", opts = {}},
    -- Neodev
    {"folke/neodev.nvim", opts = {}},
    -- Tokyonight
    {"folke/tokyonight.nvim", opts = {}},
    -- Plenary (library for telescope)
    {"nvim-lua/plenary.nvim"},
    -- Telescope
    {"nvim-telescope/telescope.nvim", opts = {}},
    -- Nvim-Lspconfig
    { "neovim/nvim-lspconfig", },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    -- Lsp-related
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-nvim-lua"},
    {"hrsh7th/cmp-nvim-lsp-signature-help"},
    {"hrsh7th/cmp-vsnip"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/vim-vsnip"},
    {"puremourning/vimspector"},
    -- Commenting
    {
        "numToStr/Comment.nvim",
        opts = { },
        lazy = false
    },
    {"hadronized/hop.nvim", opts = {}},
    {"mg979/vim-visual-multi"},
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
    {"m4xshen/autoclose.nvim", opts = {
        keys = {
            ["("] = { escape = false, close = true, pair = "()" },
            ["["] = { escape = false, close = true, pair = "[]" },
            ["{"] = { escape = false, close = true, pair = "{}" },

            [">"] = { escape = true, close = false, pair = "<>" },
            [")"] = { escape = true, close = false, pair = "()" },
            ["]"] = { escape = true, close = false, pair = "[]" },
            ["}"] = { escape = true, close = false, pair = "{}" },

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
            disable_command_mode = false,
        },
    }},
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
    -- {
    --     "vhyrro/luarocks.nvim",
    --     priority = 1001, -- this plugin needs to run before anything else
    --     opts = {
    --         rocks = { "magick" },
    --     },
    -- },
    -- {
    --     "3rd/image.nvim",
    --     dependencies = { "luarocks.nvim" },
    --     config = function()
    --         -- ...
    --     end,
    --     opts = {
    --         tmux_show_only_in_active_window = true,
    --     }
    -- },
    {
        "epwalsh/obsidian.nvim",
        version = "*",  -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
            --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
            --   "BufReadPre path/to/my-vault/**.md",
            --   "BufNewFile path/to/my-vault/**.md",
            -- },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
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
    {
        dir = "~/Dev/nvim-lua/m3u_metadata/",
        name = "m3u_metadata",
        config = function ()
            require("m3u_metadata").setup({
                root_dir = "/home/abec/Music/external/"
            })
        end
    },
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        config = function ()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']()
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1)
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1)
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']()
            end, { expr = true, silent = true })
        end
    },
    { 'pest-parser/pest.vim' }
})
-- require("image").setup()
