return {
    {"williamboman/mason-lspconfig.nvim", opts = {}},
    -- Nvim-Lspconfig
    { "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neoconf.nvim"
        },
        config = function ()
            local on_gdscript_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local _notify = client.notify
                client.notify = function (method, params)
                    if method == 'textDocument/didClose' then
                        return
                    end
                    _notify(method, params)
                end
            end

            local lspconfig = require('lspconfig')
            lspconfig.gdscript.setup{
                on_attach = on_gdscript_attach,
                flags = {},
                filetypes = {'gd', 'gdscript', 'gdscript3'}
            }
            lspconfig.nixd.setup{
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> {}",
                        },
                        options = {
                            nixos_config = {
                                expr = '(builtins.getFlake ("/etc/nixos")).nixosConfigurations.default.options',
                            },
                        },
                    },
                },
            }
        end
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
    {'pest-parser/pest.vim'},
    {"nvim-treesitter/nvim-treesitter", opts = {}},
}
