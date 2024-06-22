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
    },
    e = {
        name = "Explorer",
    },
    o = {
        name = "Obsidian",
        d = {"Dailies"}
    }
}, { prefix = "<leader>" })




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
vim.keymap.set("n", "<leader>ee", function()
  require("oil").open()
end, {desc = "Open file explorer"})

vim.keymap.set("n", "<leader>eE", function()
  vim.cmd("vsplit | wincmd l")
  require("oil").open()
end, {desc = "Open file explorer in new tab"})



local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
opts.desc = "Code Action"
vim.api.nvim_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
opts.desc = "Code Action"
vim.api.nvim_set_keymap("v", "<leader>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
opts.desc = "Signature Help"
vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",opts)
opts.desc = "Lsp Rename"
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
opts.desc = "Lsp References"
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>', opts)
-- vim.api.nvim_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>', opts)

-- Obsidian.nvim 
vim.keymap.set("n", "<leader>of", function()
    vim.cmd("ObsidianSearch")
end,
{desc="Search in notes"}
)
vim.keymap.set("n", "<leader>oo", function()
    vim.cmd("ObsidianQuickSwitch")
end,
{desc="Quick Switch"}
)
vim.keymap.set("n", "<leader>or", function()
    vim.ui.input({prompt = "Enter new name: "}, function (new_name)
        if not (new_name == nil) and not (new_name == '') then
            vim.cmd("ObsidianRename "..new_name)
        else
            vim.print("No input given, aborting "..new_name)
        end
    end)
end,
{desc="Rename Current"}
)
vim.keymap.set("n", "<leader>oR", function()
    vim.ui.input({prompt = "Enter new name: "}, function (new_name)
        if not (new_name == nil) and not (new_name == '') then
            vim.cmd("ObsidianRename "..new_name.." --dry-run")
        else
            vim.print("No input given, aborting "..new_name)
        end
    end)
end,
{desc="Rename Dry Run"}
)
vim.keymap.set("n", "<leader>on", function()
    vim.cmd("ObsidianNew")
end,
{desc="New Note"}
)
vim.keymap.set("n", "<leader>ow", function()
    vim.cmd("ObsidianWorkspace")
end,
{desc="Change Workspace"}
)
vim.keymap.set("n", "<leader>op", function()
    vim.cmd("ObsidianPasteImg")
end,
{desc="Paste Image"}
)
vim.keymap.set("n", "<leader>odd", function()
    vim.cmd("ObsidianDailies")
end,
{desc="Select dailiy"}
)
vim.keymap.set("n", "<leader>odt", function()
    vim.cmd("ObsidianToday")
end,
{desc="Today"}
)
vim.keymap.set("n", "<leader>ody", function()
    vim.cmd("ObsidianYesterday")
end,
{desc="Yesterday"}
)
vim.keymap.set("n", "<leader>odm", function()
    vim.cmd("ObsidianTomorrow")
end,
{desc="Tomorrow"}
)

-- Markdown preview
vim.keymap.set("n", "<leader>ot", function ()
    local cur = tostring(vim.g.mkdp_auto_start)
    if cur == '1' then
        vim.cmd("let g:mkdp_auto_start = 0")
        print("Auto start disabled")
    else
        vim.cmd("let g:mkdp_auto_start = 1")
        print("Auto start enabled")
    end
end)
