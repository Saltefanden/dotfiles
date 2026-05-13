-- Notes:
-- Difference between vim.o and vim.opt see 
-- :h lua-guide

-- Numbering

vim.o.number = true
vim.o.relativenumber = true

-- Search

vim.o.ignorecase = true
vim.o.smartcase = true

-- Buffer

vim.o.scrolloff = 3
vim.o.sidescrolloff = 10
vim.o.colorcolumn = "80"
vim.o.wrap = false
-- vim.o.fillchars = "eob:?"
vim.o.signcolumn = 'yes'
vim.o.breakindent = true
vim.o.undofile = true

-- Cursor

vim.o.cursorline = true
vim.cmd([[
    aunmenu PopUp.How-to\ disable\ mouse
    aunmenu PopUp.-2-
]])

-- Text

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.formatoptions = "tljcqrn"  -- :h fo-table

-- Highlights

vim.o.showmatch = true
vim.o.matchtime = 1

-- Visual
vim.o.virtualedit   = 'block' -- Allow going past end of line in blockwise mode

-- Experimental....
-- vim.o.autocomplete = true   -- Always try autocompleting
vim.o.pumheight = 10   -- Height of menu
vim.o.pumblend = 3
vim.o.complete        = '.,w,b,kspell'                  -- Use less sources
vim.o.completeopt     = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior

vim.cmd[[
    set path+=**
]]
