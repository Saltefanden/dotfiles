vim.pack.add({
    -- Look at the formatter page here for new ideas.
    'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    formatters_by_ft = { python = { 'ruff_format', 'ruff_fix'} },
})
