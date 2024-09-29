-- options = {
--     opt = {
--         -- set to true or false etc.
--         relativenumber = true, -- sets vim.opt.relativenumber
--         number = true, -- sets vim.opt.number
--         spell = false, -- sets vim.opt.spell
--         signcolumn = "auto", -- sets vim.opt.signcolumn to auto
--     },
-- }
local set = vim.opt -- set options
set.relativenumber = true
set.signcolumn = "yes"
set.shiftwidth = 4
set.smarttab = true
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4

vim.wo.number = true
vim.wo.relativenumber = true

-- Required for Obsidian.nvim 
vim.cmd("set conceallevel=2")




-- Autocompletion 

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-a>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-e>'] = cmp.mapping.close(),
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 1 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 1},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'vsnip', keyword_length = 1 },         -- nvim-cmp source for vim-vsnip 
    { name = 'codeium', keyword_length = 0}
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = '󰏉',
              path = '',
              codeium = '',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- Treesitter plugin 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml", "python" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

vim.wo.foldmethod = 'manual'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'


vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.tsserver.setup{}
lspconfig.lua_ls.setup{}
lspconfig.wgsl_analyzer.setup{}
lspconfig.nil_ls.setup{}
lspconfig.clangd.setup{}

require('mason-lspconfig').setup_handlers {

    ['pest_ls'] = function ()
        require('pest-vim').setup {}
    end,
}
