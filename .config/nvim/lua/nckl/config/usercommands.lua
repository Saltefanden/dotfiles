vim.cmd([[
    if !exists(":DiffOrig")
      command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
              \ | wincmd p | diffthis
    endif
]])

vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

vim.api.nvim_create_user_command('OpenTerm', function(direction)
   -- 1. Decide the split type
    if direction.fargs[1] == "side" then
        vim.cmd("botright vsplit")
    elseif direction.fargs[1] == "bottom" then
        -- Default to bottom if no arg or "bottom" is passed
        vim.cmd("botright split")
        vim.cmd("resize" .. (vim.v.count>1 and vim.v.count or 10)) -- Adjust height for bottom terminal
    end
    -- 2. Open the terminal
    vim.cmd("term")
    -- -- -- 3. Standard terminal cleanup/settings
    vim.cmd("startinsert")
end, {count=true, nargs = 1, complete = function() return {"bottom", "side"} end})
