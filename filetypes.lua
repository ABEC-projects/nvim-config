vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {"markdown"}, -- list of language that will be disabled
  },
}

vim.api.nvim_create_autocmd({"BufEnter"},{
    pattern = {"*.nix"},
    callback = function()
        local opt = vim.bo -- set options
        opt.shiftwidth = 2
        opt.expandtab = true
        opt.tabstop = 2
        opt.softtabstop = 2
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})
