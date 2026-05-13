-- Already sourced?
-- vim.pack.add({
--     'https://github.com/nvim-mini/mini.nvim'
-- })

require("mini.ai").setup()

require("mini.pairs").setup()
require("mini.diff").setup()
require('mini.statusline').setup()

require("mini.extra").setup()
require("mini.pick").setup()
require("mini.git").setup()
require("mini.jump").setup({
    mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = 't',
        backward_till = 'T',
        repeat_jump = ';',
    },
    delay = {
        idle_stop = 0, -- Disallows fFtT repeats
    }
})

require("mini.completion").setup({
    delay = { completion = 0, info = 0, signature = 0},
})

local map_multistep = require('mini.keymap').map_multistep

map_multistep('i', '<Tab>',   { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>',    { 'minipairs_bs' })


local gen_loader = require('mini.snippets').gen_loader

require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

require('mini.bracketed').setup()

local miniclue = require("mini.clue")

miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
        { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
        { mode = 'n', keys = '<Leader>f', desc = '+Find' },
        { mode = 'n', keys = '<Leader>g', desc = '+Git' },
        { mode = 'n', keys = '<Leader>l', desc = '+Language' },
        { mode = 'n', keys = '<Leader>m', desc = '+Map' },
        { mode = 'n', keys = '<Leader>o', desc = '+Other' },
        { mode = 'n', keys = '<Leader>s', desc = '+Session' },
        { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
        { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
        { mode = 'x', keys = '<Leader>g', desc = '+Git' },
        { mode = 'x', keys = '<Leader>l', desc = '+Language' },
  },
  window = { delay = 0}
})

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

