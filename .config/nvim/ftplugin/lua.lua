-- for nvim configs
vim.keymap.set("n", "<leader>h", ":h <C-r><C-w><CR>",
    { desc = "Navigate vim help word under cursor" })

vim.lsp.enable("lua_ls")
