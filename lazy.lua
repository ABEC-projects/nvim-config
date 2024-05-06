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
        },
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    --{"m4xshen/autoclose.nvim", opts = {}},
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
            }
        end
    }
})
