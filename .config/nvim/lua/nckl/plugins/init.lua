-- Look at which standard plugins are loaded by default:
-- :h plugins
vim.cmd('packadd! nohlsearch')
vim.cmd('packadd! nvim.undotree')

vim.pack.add({
    -- Syntax highlighting
    'https://github.com/nvim-treesitter/nvim-treesitter', 

    -- Color scheme
    'https://github.com/AlexvZyl/nordic.nvim',

    -- Git
    'https://github.com/tpope/vim-fugitive',

    -- Surround
    'https://github.com/tpope/vim-surround',

    -- Textobjects Currently look like having a learning curve..
    -- 'https://github.com/nvim-mini/mini.ai'

    -- Completion
    'https://github.com/nvim-mini/mini.completion',

    -- Auto indent with pairs
    'https://github.com/nvim-mini/mini.pairs',

    -- Keymaps supporting stuff
    'https://github.com/nvim-mini/mini.keymap'

    -- Scroll off feeling natural with gg
    'https://github.com/Aasim-A/scrollEOF.nvim'
})

vim.cmd.colorscheme("nordic")

require("nvim-treesitter").install({"bash", "c", "cpp", "json", "lua", "markdown", "markdown_inline", "python", "julia"})

require("mini.pairs").setup()

require("mini.completion").setup({
    delay = { completion = 0, info = 0, signature = 0}, -- Feel snappy
    -- lsp_completion = { source_func = "omnifunc"} -- No idea what this does..
})

local map_multistep = require('mini.keymap').map_multistep

map_multistep('i', '<Tab>',   { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>',    { 'minipairs_bs' })

require("scrollEOF").setup()
