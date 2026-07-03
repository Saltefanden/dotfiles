-- Look at which standard plugins are loaded by default:
-- :h plugins
vim.cmd('packadd! nohlsearch')
vim.cmd('packadd! nvim.undotree')

require("nckl.plugins.mini")
require("nckl.plugins.nvim-treesitter")
require("nckl.plugins.colorschemes")
require("nckl.plugins.canola")
require("nckl.plugins.tpope")
require("nckl.plugins.conform")
require("nckl.plugins.image")
