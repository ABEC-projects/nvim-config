local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- Changing Mapleader
vim.g.mapleader = " "


-- Which Key
local wk = require("which-key")
wk.register({
    f = {
        name = "file", -- optional group name
        f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
        n = { "New File" }, -- just a label. don't create any mapping
        e = "Edit File", -- same as above
        ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    },
    z = {
        name = "Fold/unfold",
        ["["] = {"zfi[", "Fold [] square brackets"},
        ["{"] = {"zfi{", "Fold {} curly brackets"},
        o = {"zo", "Unfold"}
    },
    L = {":Lazy", "Opn Lazy"},
    f = {
        name = "Find (Telescope)",
        f = {"Find files"},
        g = {"Live grep"},
        b = {"Buffers"},
        h = {"Help tags"}
    }
}, { prefix = "<leader>" })


-- Hop plugin
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})


-- Terminal mappings
map("n", "<C-t>", ":term<CR>", { noremap = true }) -- open
map("t", "<Esc>", "<C-\\><C-n>") -- exit


-- Faster Window Travelling
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")


-- Telescope
local telbuiltin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telbuiltin.find_files, {})
vim.keymap.set("n", "<leader>fg", telbuiltin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telbuiltin.buffers, {})
vim.keymap.set("n", "<leader>fh", telbuiltin.help_tags, {})

-- Yanky Settings
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Rust Related
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
-- Vimspector
vim.cmd([[
nmap <F5> <cmd>call vimspector#Launch()<cr>
nmap <F4> <cmd>call vimspector#Reset()<cr>
nmap <F7> <cmd>call vimspector#StepOver()<cr>")
nmap <F8> <cmd>call vimspector#StepOut()<cr>")
nmap <F6> <cmd>call vimspector#StepInto()<cr>")
]])
-- map("n", "Db", ":call vimspector#ToggleBreakpoint()<cr>")
-- map("n", "Dw", ":call vimspector#AddWatch()<cr>")
-- map("n", "De", ":call vimspector#Evaluate()<cr>")

-- Oil.nvim 
require("oil").open()
vim.keymap.set("n", "<leader>ee", function()
  -- vim.cmd("vsplit | wincmd l")
  require("oil").open()
end, {desc = "Open file explorer"})

vim.keymap.set("n", "<leader>eE", function()
  vim.cmd("vsplit | wincmd l")
  require("oil").open()
end, {desc = "Open file explorer in new tab"})

vim.keymap.set('n', '<leader>ss', "<cmd>SessionSave<CR>", {desc= "Save current session"})
vim.keymap.set('n', '<leader>sr', "<cmd>SessionRestore<CR>", {desc= "Restore saved session"})


local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>', opts)
vim.api.nvim_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>', opts)
