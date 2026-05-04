vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
  desc = "Highlight on yank",
})


vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
            vim.opt_local.formatoptions:remove({ "r", "o" })
		end,
        desc = "Disable automatic comment on newline"
})


vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
        if vim.o.diff then -- except in diff mode
            return 
        end
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
    desc = "Restore cursor position on file open"
})


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    vim.g.startup_time_ms = string.format("%.2f ms", startuptime * 1000)
  end,
  desc = "Log the startuptime to a variable"
})


vim.api.nvim_create_autocmd('FileType', {
  pattern = { "bash", "c", "cpp", "json", "lua", "markdown", "markdown_inline", "python", "julia" },
  callback = function() 
      vim.treesitter.start() 
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.o.foldenable = false
  end,
})
