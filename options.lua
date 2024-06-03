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
vim.api.nvim_set_option('updatetime', 300)

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
    -- Add tab srpport
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 1 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 1},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 1 },        -- source current buffer
    { name = 'vsnip', keyword_length = 1 },         -- nvim-cmp source for vim-vsnip 
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


-- VImspector
vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

-- Python lsp
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.tsserver.setup{}
lspconfig.lua_ls.setup{}
lspconfig.pest_language_server.setup{}

-- Autosession
require("auto-session").setup{
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    auto_session_enable_lastsession = true,
    auto_save_enabled = true,
}

-- Obsidian
require("obsidian").setup({
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
        }
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
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        config = function ()
            require("codeium").setup()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']()
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1)
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1)
            end, { expr = true, silent = true })

            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']()
            end, { expr = true, silent = true })
        end
    },
})
