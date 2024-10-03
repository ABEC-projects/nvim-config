vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {"markdown"}, -- list of language that will be disabled
  },
}
