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
--flocal wk = require("which-key")
-- wk.register({
--     z = {
--         name = "Fold/unfold",
--         ["["] = {"zfi[", "Fold [] square brackets"},
--         ["{"] = {"zfi{", "Fold {} curly brackets"},
--         o = {"zo", "Unfold"}
--     },
--     f = {
--         name = "Find (Telescope)",
--         f = {"Find files"},
--         g = {"Live grep"},
--         b = {"Buffers"},
--         h = {"Help tags"}
--     },
--     e = {
--         name = "Explorer",
--     },
--     o = {
--         name = "Obsidian",
--         d = {"Dailies"}
--     }
-- }, { prefix = "<leader>" })




-- Terminal mappings
map("n", "<C-t>", ":term<CR>", { noremap = true }) -- open
vim.keymap.set("n", "<C-S-t>", function ()
    vim.cmd.cd(vim.g.project_root)
    vim.cmd.terminal()
end, { noremap = true }) -- open
map("t", "<Esc>", "<C-\\><C-n>") -- exit


-- Telescope
local telbuiltin = require("telescope.builtin")
-- local telescope = require("telescope")
vim.keymap.set("n", "<leader>fb", telbuiltin.buffers, {})
vim.keymap.set("n", "<leader>fh", telbuiltin.help_tags, {})
vim.keymap.set("n", "<leader>ff", function ()
    local dir = vim.g.project_root
    if dir == nil then
        dir = vim.cmd.pwd()
    end
    vim.cmd.cd(dir)
    telbuiltin.find_files()
end, {})
vim.keymap.set("n", "<leader>fg", function ()
    if  vim.g.project_root ~= "" then
        vim.cmd.cd(vim.g.project_root)
    end
    telbuiltin.live_grep()
end, {})
vim.keymap.set("n", "<leader>fc", function ()
    telbuiltin.current_buffer_fuzzy_find()
end, {})

-- Yanky Settings
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")


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
vim.api.nvim_set_keymap("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
opts.desc = "Lsp References"
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
opts.desc = "Lsp Format Buf"
vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
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

map("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)
