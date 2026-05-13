vim.pack.add({
    'https://github.com/AlexvZyl/nordic.nvim',
    'https://github.com/slugbyte/lackluster.nvim',
})

require("nordic").setup({
    cursorline = {
        blend = 0.3  -- Only a slight hint of the cursorline
    },
    visual = {
        theme = 'light', -- Reverse theme mode for better visual
        blend = 0.9
    },
    -- transparent = {
    --     bg = true
    -- }
})

require("lackluster").setup({
    tweak_syntax = {
        comment = "#606F6F"
    }
})

vim.cmd.colorscheme("nordic")
-- vim.cmd.colorscheme("lackluster")

