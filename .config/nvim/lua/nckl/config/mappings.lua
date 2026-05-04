vim.g.mapleader = " "

-- Window navigation maps
vim.keymap.set("n", "<leader>1", vim.cmd.Ex,
    { desc = "Open Ex navigation" })
vim.keymap.set("n", "<leader><Enter>", vim.cmd.term,
    { desc = "Open a terminal" })


-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", '<C-\\><C-n>',
    { desc = "Use <Esc> to exit terminal mode" })


vim.keymap.set("n", "<C-j>", ":m .+1<CR>==") -- Errors on invalid range..
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv") -- Errors on invalid range..
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")


-- Less disorienting page scrolls
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- System clipboard usage with leader y
vim.keymap.set( {"n", "v"} , "<leader>y", "\"+y", 
    { desc = "Use system clipboard with <leader>y" })

vim.keymap.set( {"n", "v"} , "<leader>Y", "\"+Y",
    { desc = "Use system clipboard with <leader>Y" })

vim.keymap.set( "x", "<leader>p", '"_dP', 
    { desc = "In visual mode exclusively (not select mode), paste without yanking" })

vim.keymap.set( { "n", "v" }, "<leader>x", '"_d',
    { desc = "Delete without yanking" })
    
vim.keymap.set( "x", ">", ">gv",
    { desc = "Indent with reselet" })

vim.keymap.set( "x", "<", "<gv",
    { desc = "Unindent with reselet" })


-- Diagnostics stuff

vim.keymap.set( "n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set( "n", "gD", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end)
