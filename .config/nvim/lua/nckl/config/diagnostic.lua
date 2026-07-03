-- Note to self! 
-- All of this crap is due to the E and W in the sign column from the lsp. This
-- is all the diagnostic stuff that I was playing around with.. Here are the remnants


-- vim.diagnostic.handlers.loclist = {
--   show = function(_, _, _, opts)
--     -- Generally don't want it to open on every update
--     opts.loclist.open = opts.loclist.open or false
--     local winid = vim.api.nvim_get_current_win()
--     vim.diagnostic.setloclist(opts.loclist)
--     vim.api.nvim_set_current_win(winid)
--   end
-- }
--
-- vim.diagnostic.config({
--     underline=false,
--     loclist = {
--         open = true,
--         severity = {min = vim.diagnostic.severity.INFO},
--     }
-- })
--

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'HINT', max = 'ERROR' } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = 'WARN', max = 'ERROR' } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
