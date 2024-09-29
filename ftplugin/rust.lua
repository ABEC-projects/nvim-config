local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>ra",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<leader>rod",
    function()
        vim.cmd.RustLsp('openDocs')
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<leader>roc",
    function()
        vim.cmd.RustLsp('openCargo')
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<leader>rmd",
    function()
        vim.cmd.RustLsp('moveItem down')
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<leader>rmu",
    function()
        vim.cmd.RustLsp('moveItem up')
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<leader>rpm",
    function()
        vim.cmd.RustLsp('parentModule')
    end,
    { silent = true, buffer = bufnr }
)
