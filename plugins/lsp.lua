return {
    {"williamboman/mason-lspconfig.nvim", opts = {}},
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
    { 'pest-parser/pest.vim' },
    {"nvim-treesitter/nvim-treesitter", opts = {}},
}
